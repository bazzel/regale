Given("there are {int} events") do |events_count|
  create_list :event, events_count
end

Given("I add {string} as a guest") do |guest_name|
  within('form') do
    check(guest_name)
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
  expect(page).to have_content('New event')
  within('form') do
    expect(page).to have_button('Save')
  end
end

Then("I see the event {string} with {int} guests") do |event_title, guests_count|
  element = find('.list-group.list-view-pf .list-group-item', text: event_title)

  expect(element).to have_content(guests_count)
end
