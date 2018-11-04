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

Given("I sign up with my email address {string}") do |email|
  @user = create(:user, email: email)

  step %q(I open the application)
  step %Q(I fill in "Email" with "#{email}")
  step %q(I click "Sign In")
end

When('I use the magic link') do
  visit token_sign_in_url(@user.reload.login_token)
end

Then("I'm in") do
  expect(page).to have_text("Welcome, #{@user.email}")
end

Given("I signed in with my email address {string}") do |email|
  step %Q(I sign up with my email address "#{email}")
  step %q(I use the magic link)
end

When("I sign out") do
  within('ul.navbar-utility') do
    click_on @user.email
    click_on 'Logout'
  end
end
