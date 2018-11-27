Feature:
  As a user
  I want to add guests to an event
  So they can see they're invited

  @javascript
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
    And I add "lorraine@example.com" as a guest
    And I click "Save"
    Then I see the event "Italian dinner" with 2 guests

  Scenario: Add guests to an existing event

  Scenario: Remove a guest

  @javascript
  Scenario: Delete a user
    Given the following users:
      | email                | name  |
      | marty@example.com    | Marty |
      | lorraine@example.com |       |
      | emmett@example.com   | Doc   |
    And I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at        | guests                                  |
      | Italian dinner | 1-1-2018 6:00 pm | marty@example.com, lorraine@example.com |
    When I'm viewing the users
    And I delete the user "Marty"
    And I edit the event "Italian dinner"
    Then I don't see the guest "Marty"
