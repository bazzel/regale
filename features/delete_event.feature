Feature:
  As a user
  I want to delete an event
  So `Regale` stays organized

  @javascript
  Scenario: Delete an event
    Given I signed in as admin "john.doe@example.com"
    And the following event:
      | title          | starts_at       | guests               |
      | Italian dinner | 1 week from now | john.doe@example.com |
    And I'm viewing the events
    And I delete the event "Italian dinner"
    Then I see a list of 0 events

