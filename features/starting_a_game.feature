Feature: Starting the game
    In order to play battleships
    As a nostalgic player
    I want to start a new game

    Scenario: Registering
    Given I am on the homepage
    When I follow "New Game"
    Then I should see "What's your name?"

    Scenario: Registering name input
    Given I am on the new_game page
    When I fill in "name" with "Andy"
    And I click "submit"
    Then player name should be "Andy"