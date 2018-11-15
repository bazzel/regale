Feature:
  As a user
  I want to add an event
  So I can ask my colleagues can sign in

  Scenario: List events
    Given I signed in with my email address "john.doe@example.com"
    And there are 12 events
    When I choose "All Events" from the "Events" menu
    Then I see a list of 12 event

  @wip
  @javascript
  Scenario: See division of courses for an event
    Given the following users:
      | email                | name  |
      | marty@example.com    | Marty |
      | lorraine@example.com |       |
      | emmett@example.com   | Doc   |
    And I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at       | guests                                                        |
      | Italian dinner | 1 week from now | marty@example.com, lorraine@example.com, john.doe@example.com |
    And the event "Italian dinner" has the following menu:
      | course       | dishes                 |
      | appetizers   | carpaccio, tomato soup |
      | main_courses | pizza, spaghetti       |
      | desserts     | tiramisu, limoncello   |
    And the event "Italian dinner" has the following responses:
      | guest                | accept_status | appetizer   | main_course | dessert  |
      | marty@example.com    |               |             |             |          |
      | lorraine@example.com | yes           | tomato soup | pizza       |          |
      | john.doe@example.com | maybe         | carpaccio   | pizza       | tiramisu |
    When I'm viewing the events
    And I'm expanding the "Courses" for the event "Italian dinner"
    Then I see an expansion showing the following appetizers:
      | dish        | guests               |
      | tomato soup | lorraine@example.com |
      | carpaccio   | john.doe@example.com |
    And I see an expansion showing the following main courses:
      | dish  | guests                                     |
      | pizza | lorraine@example.com, john.doe@example.com |
    And I see an expansion showing the following desserts:
      | dish     | guests               |
      | tiramisu | john.doe@example.com |

