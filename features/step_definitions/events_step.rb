Given("there are {int} events") do |events_count|
  create_list :event, events_count
end

Given("the following event:") do |table|
  table.map_headers!('starts_at' => :scheduled_at)
  table.map_column!('starts_at') { |s| Chronic.parse(s) }
  table.map_column!('guests') { |emails| emails.split(/\s*,\s*/) }

  table.hashes.each do |h|
    guests_email = h.delete('guests')
    create(:event, h) do |u|
      u.users = User.where(email: guests_email)
    end
  end
end

Given("the {event} has the following menu:") do |event, table|
  table.hashes.each do |h|
    h['dishes'].split(/\s*,\s*/).each do |dish_title|
      event.send(h['course']).create(title: dish_title)
    end
  end
end

Given("the {event} has the following responses:") do |event, table|
  table.map_column!('guest')              { |guest| event.guests.detect{ |g| g.user.email == guest } }
  table.map_column!('accept_status')      { |status| status.blank? ? nil : status }
  table.map_column!('soup', false)        { |soup| event.soups.find_by(title: soup) }
  table.map_column!('appetizer', false)   { |appetizer| event.appetizers.find_by(title: appetizer) }
  table.map_column!('main_course', false) { |main_course| event.main_courses.find_by(title: main_course) }
  table.map_column!('dessert', false)     { |dessert| event.desserts.find_by(title: dessert) }

  table.hashes.each do |h|
    h.delete('guest').update(h)
  end
end

Given("I add {string} as a guest") do |guest_name|
  within('form') do
    check(guest_name)
  end
end

Given("I add {string} as a dish to {string}") do |dish_name, courses_name|
  within('.form-group', text: courses_name) do
    course_name = courses_name.singularize
    click_on("Add #{course_name}")

    field = all('.nested-fields').last
    field.find_field("Title of the #{course_name.downcase}").fill_in with: dish_name
  end
end

Given("I'm expanding the {string} for the event {string}") do |course_name, event_name|
  item = find('.list-group-item', text: event_name)
  item.find('.list-view-pf-additional-info-item', text: course_name).click
end

Then("I see a list of {int} event(s)/user(s)") do |items_count|
  within('.list-group.list-view-pf') do
    expect(page).to have_css('.list-group-item', count: items_count)
  end
end

Then("I see a validation error for {string}") do |label|
  within('form') do
    expect(page).to have_css('.form-group.has-error', text: label)
  end
end

Then("I can add a new event") do
  expect(page).to have_content('New Event')
  within('form') do
    expect(page).to have_button('Save')
  end
end

Then("I see the event {string} with {int} guests") do |event_title, guests_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)
  name = 'Guest'.pluralize(guests_count)

  expect(element).to have_content(/#{guests_count}\n*#{name}/)
end

Then("I see the event {string} with {int} courses") do |event_title, courses_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)
  course_label = 'Course'.pluralize(courses_count)

  expect(element).to have_content(/#{courses_count}\n*#{course_label}/)
end

Then("I don't see the guest {string}") do |guest_name|
  within('form .event_users') do
    expect(page).not_to have_content(guest_name)
  end
end

Then("I see the course {string}") do |course_name|
  expect(page).to have_content(course_name)
end

Then("I don't see the course {string}") do |course_name|
  expect(page).not_to have_content(course_name)
end

Then(/I see an expansion showing the following (soup|appetizer|main course|dessert):/) do |course_name, table|
  table.map_column!('guests') { |emails| emails.split(/\s*,\s*/) }

  within('.list-group-item-container.container-fluid:not(.hidden)') do
    expect(page).to have_content('Courses')
    expect(page).to have_content(/#{course_name}/i)

    table.hashes.each do |h|
      element = find('dl dt', text: h['dish']).ancestor('dl')

      h['guests'].each do |guest|
        expect(element).to have_content(guest)
      end
    end
  end
end
