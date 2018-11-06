Feature:
  As a guest
  I want to respond to my invite
  So it's clear I'm coming or not

  @wip
  Scenario: View invites
    Given the following users:
      | email                | name  |
      | marty@example.com    | Marty |
      | lorraine@example.com |       |
      | emmett@example.com   | Doc   |
    And I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at        | guests                                     |
      | Rabarber party | 4 days ago       | john.doe@example.com, lorraine@example.com |
      | Italian dinner | tomorrow         | john.doe@example.com, lorraine@example.com |
      | Pizza          | 3 days from now  | Marty, lorraine@example.com                |
      | Greek dinner   | 1 week from now  | john.doe@example.com, lorraine@example.com |
    When I open the application
    Then I see an invite for "Italian dinner"
    And I see an invite for "Greek dinner"
    But I don't see an invite for "Rabarber party"
    And I don't see an invite for "Pizza"

  Scenario: Accept

  Scenario: Decline

  Scenario: Maybe

  Scenario: Change response
