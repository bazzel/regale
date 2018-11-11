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

Given("I add {string} as a guest") do |guest_name|
  within('form') do
    check(guest_name)
  end
end

Given("I add {string} as a course") do |course_name|
  click_on('Add Course')
  field = all('form .courses .nested-fields').last

  field.find_field('Title of the course').fill_in with: course_name
end

Given("I add {string} as a dish to {string}") do |dish_name, course_name|
  course_field = all('.courses input[placeholder="Title of the course"]').find { |e| e.value == course_name }
  course_div = course_field.ancestor('.nested-fields')

  course_div.click_on('Add Dish')

  dish_field = course_div.all('form .dishes').last.all('.nested-fields').last
  dish_field.find_field('Title of the dish').fill_in with: dish_name
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

  expect(element).to have_content("#{guests_count}#{name}")
end

Then("I see the event {string} with {int} courses") do |event_title, courses_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)

  expect(element).to have_content("#{courses_count} Course")
end

Then("I see the event {string} with {int} dishes") do |event_title, dishes_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)

  expect(element).to have_content("#{courses_count} Dish")
end

Then("I don't see the guest {string}") do |guest_name|
  within('form .event_users') do
    expect(page).not_to have_content(guest_name)
  end
end
