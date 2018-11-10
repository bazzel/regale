When("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
  find_field(locator).send_keys :escape if js?
end


