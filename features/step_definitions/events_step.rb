Given("there are {int} events") do |events_count|
  create_list :event, events_count
end

Given("the following event:") do |table|
  table.map_headers!('starts_at' => :scheduled_at)
  table.map_column!('starts_at') { |s| Chronic.parse(s) }

  table.hashes.each do |h|
    guests_email = h.delete('guests').split(/\s*,\s*/)
    create(:event, h) do |u|
      u.users = User.where(email: guests_email)
    end
  end
end

Given("the event {string} has the following menu:") do |event_name, table|
  event = Event.find_by(title: event_name)

  table.hashes.each do |h|
    Course.create(event: event, title: h['course']) do |course|
      h['dishes'].split(/\s*,\s*/).each do |dish_title|
        course.dishes.build(title: dish_title)
      end
    end
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

Then("I see the event {string} with {int} courses and {int} dishes") do |event_title, courses_count, dishes_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)
  course_label = 'Course'.pluralize(courses_count)
  dish_label = 'Dish'.pluralize(dishes_count)

  expect(element).to have_content(/#{courses_count}\n*#{course_label}/)
  expect(element).to have_content(/#{dishes_count}\n*#{dish_label}/)
end

Then("I see the event {string} with {int} dishes") do |event_title, dishes_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)
  name = 'Dish'.pluralize(dishes_count)

  expect(element).to have_content(/#{dishes_count}\n*#{name}/)
end

Then("I don't see the guest {string}") do |guest_name|
  within('form .event_users') do
    expect(page).not_to have_content(guest_name)
  end
end
