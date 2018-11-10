Feature:
  As a user
  I want to add courses to an event
  So guests can take their pick

  @wip
  Scenario: Add appetizer, main course and dessert
    Given I signed in with my email address "john.doe@example.com"
    And I'm adding a new event
    When I fill in "Title" with "Italian dinner"
    And I fill in "Starts at" with "1-1-2018 6:00 PM"
    And I add "appetizer" as a course
    And I add a new course
    And I add "main course" as a course
    And I add a new course
    And I add "dessert" as a course
    And I click "Save"
    Then I see the event "Italian dinner" with 3 courses


