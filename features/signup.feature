Feature:
  As a user
  I want to be able to sign-up
  So I can edit and view my meals

  Scenario: Show the sign up page
    Given I am a new user
    When I open the application
    Then I see the sign up page

  Scenario: Sign up with valid email address
    Given I am a new user
    When I open the application
    And I fill in "Email" with "john.doe@example.com"
    And I click "Sign In"
    Then "john.doe@example.com" should receive an email
    And I see a page with instructions for "john.doe@example.com" how to login


  Scenario: Sign in with valid url
    Given I sign up with my email address "john.doe@example.com"
    When I use the magic link
    Then I'm in

  @todo
  Scenario: Sign up with invalid email address

  @todo
  Scenario: Sign in with invalid url

  @todo
  Scenario: Sign in with expired valid url

  # http://masa331.github.io/2016/05/21/passwordless-authentication-in-rails.html
