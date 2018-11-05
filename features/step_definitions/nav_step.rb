When("I choose {string} from the {string} menu") do |subitem, item|
  within('.nav-pf-vertical-with-sub-menus') do
    click_on item
    within('.secondary-nav-item-pf', text: item) do
      click_on subitem
    end
  end
end

Given("I'm adding a new {model_name}") do |resource|
  step %Q(I choose "Add #{resource}" from the "#{resource.pluralize}" menu)
end

When("I try to add an empty {model_name}") do |resource|
  step %Q(I'm adding a new #{resource})
  within('form') do
    click_on 'Save'
  end
end

