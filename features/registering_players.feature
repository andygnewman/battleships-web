Feature: Registering Players to play battleships
  In order to play the game of battleships
  As a person with with an opponent to play against
  I want to register the two of use to play battleships

  Scenario: Starting the game
  Given I am on the homepage
  Then I should see "Register Player 1"

  Scenario: Registering the first player
  Given I am on the homepage
  And I click "Register Player 1"
  Then I should see "Please enter a name for Player 1"

  Scenario: Having registered the first player
  Given I am ready to register the first player
  And I fill in "player_name" with "Andy"
  And I click "submit"
  Then I should see "Placing ships for Andy"

  Scenario: Registering Player 2
  Given I have registered the first player
  And I have placed all ships
  And I click "Click here to register Player 2"
  Then I should see "Please enter a name for Player 2"

  Scenario: Registering Player 2
  Given I have registered the first player
  And I have placed all ships
  And I click "Click here to register Player 2"
  Then I should see "Please enter a name for Player 2"
  And I fill in "player_name" with "Josh"
  And I click "submit"
  Then I should see "Placing ships for Josh"
