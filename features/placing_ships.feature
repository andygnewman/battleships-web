Feature: Placing ships to play battleships
  In order to play the game of battleships
  As a registered player
  I want to place my ships on my board

  Scenario: Placing ships
  Given I have registered the first player
  And I place a ship in row "A" column "3" orientation "horizontal"
  Then I should see "Please enter coordinates for Battleship"

  Scenario: Placing ships outside the grid
  Given I have registered the first player
  And I place a ship in row "G" column "10" orientation "vertical"
  Then I should see "You cannot place a ship outside the grid"

  Scenario: Placing a ship on top of another ship
  Given I have registered the first player
  And I place a ship in row "A" column "3" orientation "horizontal"
  And I place a ship in row "A" column "3" orientation "horizontal"
  Then I should see "You cannot place a ship on another ship"

  Scenario: Placing all ships in the first players fleet
  Given I have registered the first player
  And I place a ship in row "A" column "1" orientation "horizontal"
  And I place a ship in row "B" column "1" orientation "horizontal"
  And I place a ship in row "C" column "1" orientation "horizontal"
  And I place a ship in row "D" column "1" orientation "horizontal"
  And I place a ship in row "E" column "1" orientation "horizontal"
  Then I should see "You have placed all your ships"

  Scenario: Placing all ships in the second players fleet
  Given I have registered the first player
  And I have placed all ships
  And I have registered the second player
  And I have placed all ships
  Then I should see "Click here to start the battle!"
