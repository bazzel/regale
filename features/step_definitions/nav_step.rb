When("I choose {string} from the {string} menu") do |subitem, item|
  within('.nav-pf-vertical-with-sub-menus') do
    click_on item
    within('.secondary-nav-item-pf', text: item) do
      click_on subitem
    end
  end
end

Then("I cannot add a new user") do
  expect(page).not_to have_css('.navbar .navbar-toggle')
  expect(page).not_to have_css('.nav-pf-vertical')
  expect(page).not_to have_css('.container-pf-nav-pf-vertical.nav-pf-persistent-secondary')

end

Given("I'm viewing the {model_name}s") do |resource|
  resources = resource.pluralize
  step %(I choose "All #{resources}" from the "#{resources}" menu)
end

Given("I'm adding a new {model_name}") do |resource|
  step %Q(I choose "Add #{resource}" from the "#{resource.pluralize}" menu)
end

Given("I edit the {model_name} {string}") do |resource, to_label|
  resources = resource.pluralize
  step %(I'm viewing the #{resources})
  within('.list-group-item', text: to_label) do
    page.click_on('Edit')
  end
end

Given("I choose {string} from the user icon menu") do |menu_item|
  within('.navbar-utility') do
    click_button
    click_on(menu_item)
  end
end

When("I try to add an empty {model_name}") do |resource|
  step %Q(I'm adding a new #{resource})
  within('form') do
    click_on 'Save'
  end
end

When("I go to page {int}") do |page|
  within('.pagination') do
    click_on(page)
  end
end
