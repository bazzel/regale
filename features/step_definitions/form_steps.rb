When("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
  find_field(locator).send_keys :escape if js?
end

When("I select the dish {string} as {string}") do |dish_name, course_name|
  select(dish_name, from: course_name)
end
