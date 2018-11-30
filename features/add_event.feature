Feature:
  As a user
  I want to add an event
  So I can my colleagues can sign in

  Scenario: Add an event
    Given I signed in as an admin
    When I choose "Add Event" from the "Events" menu
    Then I can add a new event

  Scenario: Create an invalid event
    Given I signed in as an admin
    When I try to add an empty event
    Then I see a validation error for "Title"
    And I see a validation error for "Starts at"

  Scenario: Create an event
    Given I signed in as an admin
    And I'm adding a new event
    When I fill in "Title" with "Italian dinner"
    And I fill in "Starts at" with "1-1-2018 6:00 PM"
    And I click "Save"
    Then I see a list of 1 event

  Scenario: Create an event with a "RSVP before" later than "Starts at"
    Given I signed in as an admin
    And I'm adding a new event
    When I fill in "Title" with "Italian dinner"
    And I fill in "Starts at" with "1-1-2018 6:00 PM"
    And I fill in "RSVP before" with "13-1-2018 6:00 PM"
    And I click "Save"
    And I see a validation error for "RSVP before"

  Scenario: Edit an event

