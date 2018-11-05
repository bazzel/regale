Then("I can add a new user") do
  expect(page).to have_content('New user')
  within('form') do
    expect(page).to have_button('Save')
  end
end

Given("I'm adding a new user") do
  step %Q(I choose "Add User" from the "Users" menu)
end

When("I try to add an empty user") do
  step %Q(I'm adding a new user)
  within('form') do
    click_on 'Save'
  end
end

