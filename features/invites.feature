Feature:
  As a guest
  I want to respond to my invite
  So it's clear I'm coming or not

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
      | Pizza          | 3 days from now  | Marty, lorraine@example.com                |
      | Italian dinner | tomorrow         | john.doe@example.com, lorraine@example.com |
      | Greek dinner   | 1 week from now  | john.doe@example.com, lorraine@example.com |
    When I open the application
    Then I see 2 invites
    And I see an invite for "Italian dinner" on page 1
    And I see an invite for "Greek dinner" on page 2

  @javascript
  Scenario: Accept
    Given I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at        | guests                                     |
      | Italian dinner | tomorrow         | john.doe@example.com, lorraine@example.com |
    And I open the application
    When I accept the invite for "Italian dinner"
    Then I see I'm expected for "Italian dinner"

  @javascript
  Scenario: Decline
    Given I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at        | guests                                     |
      | Italian dinner | tomorrow         | john.doe@example.com, lorraine@example.com |
    And I open the application
    When I decline the invite for "Italian dinner"
    Then I see I'm not expected for "Italian dinner"

  @javascript
  Scenario: Maybe
    Given I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at        | guests                                     |
      | Italian dinner | tomorrow         | john.doe@example.com, lorraine@example.com |
    And I open the application
    When I say maybe to the invite for "Italian dinner"
    Then I see they're still expecting a final response for "Italian dinner"

  Scenario: Change response

  @wip
  @javascript
  Scenario: View the invite after closing date
    Given I signed in with my email address "john.doe@example.com"
    And the following event:
      | title          | starts_at        | respond_before | guests                                     |
      | Italian dinner | tomorrow         | yesterday | john.doe@example.com, lorraine@example.com |
    When I open the application
    Then I cannot respond to the invite for "Italian dinner" anymore

