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
      | course       | dishes                 |
      | appetizers   | carpaccio, tomato soup |
      | main_courses | pizza, spaghetti       |
      | desserts     | tiramisu, limoncello   |
    And I open the application
    When I select the dish "tomato soup" as "Appetizer"
    And I select the dish "pizza" as "Main Course"
    And I click "Save"
    Then I see a toast notification telling me my changes are saved

