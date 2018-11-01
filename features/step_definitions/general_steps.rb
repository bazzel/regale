When("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
end

When("I click {string}") do |locator|
  click_link_or_button locator
end
