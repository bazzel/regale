Then("I see an invite for {string}") do |event_name|
  expect(page).to have_content(event_name)
  expect(page).not_to have_content(/Welcome/)
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
  within('.card-pf') do
    click_on('Accept')
  end
end

When("I decline the invite for {string}") do |event_name|
  within('.card-pf') do
    click_on('Decline')
  end
end

When("I say maybe to the invite for {string}") do |event_name|
  within('.card-pf') do
    click_on('Maybe')
  end
end

Then("I see I'm expected for {string}") do |event_name|
  within('.card-pf') do
    expect(page).to have_button('Accept', disabled: true)
  end
end

Then("I see I'm not expected for {string}") do |event_name|
  within('.card-pf') do
    expect(page).to have_button('Decline', disabled: true)
  end
end

Then("I see they're still expecting a final response for {string}") do |event_name|
  within('.card-pf') do
    expect(page).to have_button('Maybe', disabled: true)
  end
end

Then("I cannot respond to the invite for {string} anymore") do |event_name|
  within('.card-pf') do
    expect(page).not_to have_button('Save')
    expect(page).not_to have_button('Yes')
    expect(page).not_to have_button('No')
    expect(page).not_to have_button('Maybe')
  end
end
