When("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
  find_field(locator).send_keys :escape if js?
end

When ("I select {string} from {string}") do |value, locator|
  choose(value)
end

When("I select the dish {string} as {string}") do |dish_name, course_name|
  # We use bootstrap-select so it takes so more steps
  # than just using Capybara's 'select'
  #select(dish_name, from: course_name)
  bootstrap_select(dish_name, from: course_name)
end

When("I select the {string} tab") do |tab_name|
  within('.tabs-container') do
    click_on(tab_name)
  end
end

When("I enter a very long text as additional info") do
  fill_in 'Additional Info', with: "lorem "*100
end

def bootstrap_select(value, from:)
  container = find('label', text: from).ancestor('.form-group.select')
  container.click_button
  link = container.find('ul.dropdown-menu li a', text: value)
  link.click
end
