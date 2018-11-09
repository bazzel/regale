Then("I see an invite for {string}") do |event_name|
  expect(page).to have_content(event_name)
end

Then("I don't see an invite for {string}") do |event_name|
  expect(page).not_to have_content(event_name)
end

When("I accept the invite for {string}") do |event_name|
  item = find('.card-pf', text: event_name)

  item.find('button', text: 'Accept').click
end

When("I decline the invite for {string}") do |event_name|

end

When("I say  the invite for {string}") do |event_name|

end
