Feature:
  As a user
  I want to add dishes to courses
  So guests can take their pick

  @wip
  @javascript
  Scenario: Add appetizer, main course and dessert
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new event
    When I fill in "Title" with "Italian dinner"
    And I fill in "Starts at" with "1-1-2018 6:00 PM"
    And I add "appetizer" as a course
    And I add "main course" as a course
    And I add "dessert" as a course
    And I add "carpaccio" as a dish to "appetizer"
    And I add "tomato soup" as a dish to "appetizer"
    And I add "pizza" as a dish to "main course"
    And I add "spaghetti" as a dish to "main course"
    And I add "tiramisu" as a dish to "dessert"
    And I add "limoncello" as a dish to "dessert"
    And I click "Save"
    Then I see the event "Italian dinner" with 6 dishes


