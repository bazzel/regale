Given('I am a new user') do
end

When('I open the application') do
  visit ''
end

Then("I see the sign up page") do
  expect(page).to have_text('Simply login with your email')
  expect(page).to have_text('Regale uses magic links instead of passwords.')
  expect(page).to have_field('Email')
  expect(page).to have_button('Sign In')
end
