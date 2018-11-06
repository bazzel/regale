Feature:
  As a user
  I want to add guests to an event
  So they can see they're invited

  @wip
  Scenario: Add guests to a new event
    Given the following users:
      | email                | name  |
      | marty@example.com    | Marty |
      | lorraine@example.com |       |
      | emmett@example.com   | Doc   |
    And I signed in with my email address "john.doe@example.com"
    And I'm adding a new event
    When I fill in "Title" with "Italian dinner"
    And I fill in "Starts at" with "1-1-2018 6:00 PM"
    And I add "Marty" as a guest
    And I add "lorraine@example" as a guest
    And I click "Save"
    Then I see the event "Italian dinner" with 2 guests

  Scenario: Add guests to an existing event

  Scenario: Remove a guest

  Scenario: Delete a user
