Feature: Placing Ships
    Scenario: Start set-up for Player1
    Given players "Andy" and "Emily" have registered
    When I follow "Set-up ships for Andy"
    Then I should see "Please enter coordinates for Aircraft Carrier of size 5"

    Scenario: Place first ship for Player1
    Given players "Andy" and "Emily" have registered
    And I am on set_up
   	When I fill in "start_cell0" with "A01"
    And I fill in "orientation0" with "horizontal"
    And I press Submit
    Then the Aircraft Carrier will be placed at "A01" to "E01"
    And I should see "Please enter coordinates for Battleship of size 4"

    # Scenario: Place second ship for Player1
    # Given "Andy" has placed an "Aircraft Carrier"
    # When I fill in "start_cell" with "A02"
    # And I fill in "orientation" with "horizontal"
    # And I press Submit
    # Then the Battleship will be placed at "A02" to "D02"