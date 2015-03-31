Feature: Winning the game
  As a competitive player
  I want to see a resolution to the game
  So I can have bragging rights over my opponent

  Scenario: Sinking all opponents ships
    Given we have taken shots at all ships
    Then I should see "Andy has won!"
