Feature:
  As a user
  I want to add dishes to courses
  So guests can take their pick

  @javascript
  Scenario: Add appetizer, main course and dessert
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new event
    When I fill in "Title" with "Italian dinner"
    And I fill in "Starts at" with "1-1-2018 6:00 PM"
    And I select the "Courses" tab
    And I add "tomato soup" as a dish to "Soups"
    And I add "minestrone soup" as a dish to "Soups"
    And I add "carpaccio" as a dish to "Appetizers"
    And I add "bruschetta" as a dish to "Appetizers"
    And I add "pizza" as a dish to "Main Courses"
    And I add "spaghetti" as a dish to "Main Courses"
    And I add "tiramisu" as a dish to "Desserts"
    And I add "limoncello" as a dish to "Desserts"
    And I click "Save"
    Then I see the event "Italian dinner" with 4 courses


