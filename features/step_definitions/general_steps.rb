When("I click {string}") do |locator|
  click_link_or_button locator
end

Given('I am a new user') do
end

When('I open the application') do
  visit ''
end

Then("I see a toast notification telling me my changes are saved") do
  expect(page).to have_css('.toast-pf.alert.alert-success')
end
