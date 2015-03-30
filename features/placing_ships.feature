Feature: Placing ships to play battleships
  In order to play the game of battleships
  As a registered player
  I want to place my ships on my board

  Scenario: Placing ships
  Given I have registered the first player
  And I place a ship in column "A" row "3" orientation "horizontal"
  Then I should see "Please enter coordinates for Battleship"

  Scenario: Placing ships outside the grid
  Given I have registered the first player
  And I place a ship in column "G" row "10" orientation "vertical"
  Then I should see "You cannot place a ship outside the grid"

  Scenario: Placing a ship on top of another ship
  Given I have registered the first player
  And I place a ship in column "A" row "3" orientation "horizontal"
  And I place a ship in column "A" row "3" orientation "horizontal"
  Then I should see "You cannot place a ship on another ship"

  Scenario: Placing all ships in the first players fleet
  Given I have registered the first player
  And I place a ship in column "A" row "1" orientation "horizontal"
  And I place a ship in column "B" row "1" orientation "horizontal"
  And I place a ship in column "C" row "1" orientation "horizontal"
  And I place a ship in column "D" row "1" orientation "horizontal"
  And I place a ship in column "E" row "1" orientation "horizontal"
  Then I should see "You have placed all your ships"

  Scenario: Placing all ships in the second players fleet
  Given I have registered the first player
  And I have placed all ships
  And I have registered the second player
  Then I should see "Please enter coordinates for Aircraft Carrier"
