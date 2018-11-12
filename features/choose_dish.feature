Feature:
  As a user
  I want to choose what I eat
  So it can be prepared in advance

  @javascript
  @wip
  Scenario: Choose a dish
    Given I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at       | guests               |
      | Italian dinner | 1 week from now | john.doe@example.com |
    And the event "Italian dinner" has the following menu:
      | course      | dishes                 |
      | appetizer   | carpaccio, tomato soup |
      | main course | pizza, spaghetti       |
      | dessert     | tiramisu, limoncello   |
    And I open the application
    When I select the dish "tomato soup" as "appetizer"
    And I select the dish "pizza" as "main"
    And I click "Save"
    Then I see a toast notification telling me my changes are saved

