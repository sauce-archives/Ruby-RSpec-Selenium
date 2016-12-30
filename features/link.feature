Feature: Guinea Pig link

  Scenario: Verify Link opens new page
    Given I am on the Guinea Pig homepage
    When I click on the link
    Then I should be on another page
