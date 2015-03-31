Feature: Taking shots
  In order to progress towards winning a game of battleships
  As a person with with an opponent to play against
  I want to be able to take shots at my opponents board

  Scenario: Hitting a ship
    Given registration and placement completed
    And I shoot at row "A" column "1"
    Then I should see "You hit my Aircraft Carrier!"

  Scenario: Hitting water
    Given registration and placement completed
    And I shoot at row "A" column "10"
    Then I should see "You missed!"

  Scenario: Shooting at a cell already shot at
    Given registration and placement completed
    And a round of shots has been completed row "A" column "1"
    And I shoot at row "A" column "1"
    Then I should see "This cell has already been hit."


  Scenario: Sinking a ship (patrol boat)
    Given registration and placement completed
    And a round of shots has been completed row "E" column "1"
    And I shoot at row "E" column "2"
    Then I should see "You sank my Patrol Boat"
