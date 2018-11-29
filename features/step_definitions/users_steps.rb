Then("I can add a new user") do
  expect(page).to have_content('New User')
  within('form') do
    expect(page).to have_button('Save')
  end
end

Then("I can edit my profile") do
  within('form') do
    expect(page).to have_button('Save')
  end
end

Then("I cannot edit my role") do
  within('form') do
    expect(page).not_to have_css('label', text: 'Role')
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

Then("I see {string} is a(n) {string} user") do |user_label, role|
  container = find('.list-group-item', text: user_label)

  expect(container).to have_content(role)
end
