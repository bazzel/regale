Then("I see an invite for {string}") do |event_name|
  expect(page).to have_content(event_name)
end

Then("I don't see an invite for {string}") do |event_name|
  expect(page).not_to have_content(event_name)
end
