Feature:
  As a user
  I want to add an event
  So I can my colleagues can sign in

  Scenario: List events
    Given I signed in with my email address "john.doe@example.com"
    And there are 12 events
    When I choose "All Events" from the "Events" menu
    Then I see a list of 12 event

