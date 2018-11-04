When("I choose {string} from the {string} menu") do |subitem, item|
  within('.nav-pf-vertical-with-sub-menus') do
    click_on item
    within('.secondary-nav-item-pf', text: item) do
      click_on subitem
    end
  end
end

Given("I'm adding a new event") do
  step %Q(I choose "Add Event" from the "Events" menu)
end

Given("there are {int} events") do |events_count|
  create_list :event, events_count
end

When("I try to add an empty event") do
  step %Q(I choose "Add Event" from the "Events" menu)
  within('form') do
    click_on 'Save'
  end
end

Then("I see a list of {int} event") do |events_count|
  within('.list-group.list-view-pf') do
    expect(page).to have_css('.list-group-item', count: events_count)
  end
end

Then("I see a validation error for {string}") do |label|
  within('form') do
    expect(page).to have_css('.form-group.has-error', text: label)
  end
end

Then("I can add a new event") do
  within('form') do
    expect(page).to have_button('Save')
  end
end
