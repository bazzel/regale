Then("I see an invite for {string}") do |event_name|
  expect(page).to have_content(event_name)
end

Then("I see {int} invites") do |items_count|
  within('.pagination') do
    expect(page).to have_css('li', count: items_count)
  end
end

Then("I see an invite for {string} on page {int}") do |event_name, page|
  step %Q(I go to page #{page})
  step %Q(I see an invite for "#{event_name}")
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
