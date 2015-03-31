Feature: Taking shots
  In order to progress towards winning a game of battleships
  As a person with with an opponent to play against
  I want to be able to take shots at my opponents board

  Scenario: Hitting a ship
  Given registration and placement completed
  And I shoot at column "A" row "1"
  Then I should see "what's on this page"


  Scenario: Hitting water



  Scenario: Shooting at a cell already shot at



  Scenario: Sinking a ship
