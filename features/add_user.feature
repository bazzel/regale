Feature:
  As a user
  I want to add other users
  So they can start using the application

  Scenario: Add a user
    Given I signed in with my email address "john.doe@example.com"
    When I choose "Add User" from the "Users" menu
    Then I can add a new user

  Scenario: Create a user
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "me@example.com"
    And I click "Save"
    Then I see a list of 2 users
    And I see "me@example.com" is a "User" user

  Scenario: Create a VIP user
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "me@example.com"
    And I select "VIP" from "Role"
    And I click "Save"
    Then I see "me@example.com" is a "VIP" user

  Scenario: Create an admin user
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "me@example.com"
    And I select "Administrator" from "Role"
    And I click "Save"
    Then I see "me@example.com" is an "Administrator" user

  Scenario: Create a user with empty fields
    Given I signed in with my email address "john.doe@example.com"
    When I try to add an empty user
    Then I see a validation error for "Email"

  Scenario: Create a user with duplicate email address
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "john.doe@example.com"
    And I click "Save"
    Then I see a validation error for "Email"

  Scenario: Create a user with an invalid email address
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "Jane Doe"
    And I click "Save"
    Then I see a validation error for "Email"

  Scenario: Create a user with an email address that's too long
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx@example.com"
    And I click "Save"
    Then I see a validation error for "Email"

  Scenario: Create a user with a name that's too long
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new user
    When I fill in "Email" with "me@example.com"
    When I fill in "Name" with "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    And I click "Save"
    Then I see a validation error for "Name"
