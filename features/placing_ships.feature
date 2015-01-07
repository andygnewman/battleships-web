Feature: Placing Ships
    Scenario: Start set-up for Player1
    Given players "Andy" and "Emily" have registered
    When I follow "Set-up ships for Andy"
    Then I should see "Please enter coordinates for Aircraft Carrier of size 5"

    Scenario: Continue set-up for Player1
    Given players "Andy" and "Emily" have registered
    And I am on set_up
   	When I fill in "start_cell" with "A01"
    And I fill in "orientation" with "horizontal"
    And I press Submit
    Then the Aircraft Carrier will be placed at A01 to E01
