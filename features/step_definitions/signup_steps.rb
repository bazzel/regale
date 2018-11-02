Given('I am a new user') do
end

When('I open the application') do
  visit ''
end

Then('I see the sign up page') do
  expect(page).to have_text('Simply login with your email')
  expect(page).to have_text('Regale uses magic links instead of passwords.')
  expect(page).to have_field('Email')
  expect(page).to have_button('Sign In')
end

Then("I see a page with instructions for {string} how to login") do |email|
  expect(page).to have_text('Check your email!')
  expect(page).to have_text("We've emailed a special link to #{email}. Click the link to confirm your address and get started.")
end
