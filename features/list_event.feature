Feature:
  As a user
  I want to add an event
  So I can ask my colleagues can sign in

  Scenario: No events
    Given I signed in as an admin
    And I'm viewing the events
    Then I see an empty events page

  Scenario: List events
    Given I signed in as an admin
    And there are 12 events
    When I choose the "Events" menu
    Then I see a list of 12 event

  @javascript
  Scenario: See division of courses for an event
    Given the following users:
      | email                | name  |
      | marty@example.com    | Marty |
      | lorraine@example.com |       |
      | emmett@example.com   | Doc   |
    And I signed in as admin "john.doe@example.com"
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
    Then I see an expansion showing the following appetizer:
      | dish        | guests               |
      | tomato soup | lorraine@example.com |
      | carpaccio   | john.doe@example.com |
    And I see an expansion showing the following main course:
      | dish  | guests                                     |
      | pizza | lorraine@example.com, john.doe@example.com |
    And I see an expansion showing the following dessert:
      | dish     | guests               |
      | tiramisu | john.doe@example.com |

