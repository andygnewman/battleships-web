Feature: Starting the game
    In order to play battleships
    As a nostalgic player
    I want to start a new game

    Scenario: Registering
    Given I am on the homepage
    When I follow "New Game"
    Then I should see "What's your name?"

    Scenario: Registering name input
    Given I am on new_game
    When I fill in "player_name" with "Andy"
    And I press "submit"
    Then I should see "Thank you Andy for registering"

    Scenario: No name is input
    Given I am on new_game
    When I press "submit"
    Then I should see "Please enter the player's name"

    Scenario: Registering a second player
    Given there is already a player registered named "Andy"
    When I fill in "player_name" with "Emily"
    And I press "submit"
    Then I should see "Thank you Emily, you will be playing against Andy"

