Feature:
  As a user
  I want to edit my profile
  So information about me is up to date

  Scenario: Edit profile
    Given I signed in as a guest
    When I choose "Profile" from the user icon menu
    Then I can edit my profile
    But I cannot edit my role

  Scenario: Add name
    Given I signed in as a guest
    When I edit my profile
    When I fill in "Name" with "John Doe"
    And I click "Save"
    When I see "John Doe" as label for the user icon menu
    And I see the dashboard again

  Scenario: Use an invalid email address
    Given I signed in as a guest
    When I edit my profile
    When I fill in "Email" with "this-is-not-a-valid-email-address"
    And I click "Save"
    And I see a validation error for "Email"
