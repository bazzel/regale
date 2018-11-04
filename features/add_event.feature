Feature:
  As a user
  I want to add an event
  So I can my colleagues can sign in

  Scenario: Add an event
    Given I signed in with my email address "john.doe@example.com"
    When I choose "Add Event" from the "Events" menu
    Then I can add a new event

  @wip
  Scenario: Create an invalid event
    Given I signed in with my email address "john.doe@example.com"
    When I try to add an empty event
    Then I see a validation error for "Title"
    And I see a validation error for "Starts at"

  Scenario: Create an event

  Scenario: Edit an event

  Scenario: Delete an event


