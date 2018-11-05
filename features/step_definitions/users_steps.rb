Then("I can add a new user") do
  expect(page).to have_content('New user')
  within('form') do
    expect(page).to have_button('Save')
  end
end

