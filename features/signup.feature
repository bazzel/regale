Feature:
  As a user
  I want to be able to sing-up
  So I can edit and view my meals

  Scenario: Show the sign up page
    Given I am a new user
    When I open the application
    Then I see the sign up page

  @wip
  Scenario: Sign up with valid email address
    Given I am a new user
    When I open the application
    And I fill in "Email" with "john.doe@example.com"
    And I click "Sign In"
    Then "john.doe@example.com" should receive an email
    And I see a page with instructions for "john.doe@example.com" how to login


  Scenario: Sign up with invalid email address

  Scenario: Sign in with valid url

  Scenario: Sign in with invalid url

  Scenario: Sign in with expired valid url
