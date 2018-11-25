Then("I can add a new user") do
  expect(page).to have_content('New user')
  within('form') do
    expect(page).to have_button('Save')
  end
end

Given("the following users:") do |table|
  table.hashes.each do |h|
    create :user, h
  end
end

Given("I delete the user {string}") do |user_label|
  within('.list-group-item', text: user_label) do
    accept_confirm do
      page.click_on('Delete')
    end
  end
end
