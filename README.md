#Batleships Web

This was the Makers Academy week three exercise, building on week two's exercise of generating the logic of the battleships game in Ruby, to bring it to life with a web front end built with Sinatra and utilising Cucumber / Capybara for test driven development.

##Learning Objectives
The key objectives of this exercise were to learn;
- creating an interface on business logic
- understanding sessions
- rudimentary front end HTML & CSS
- creating a server

This was our first piece of work that encompassed front end.

During the challenge week little progress was made as we battled with our understanding of Sinatra and making it fit with a game logic built without a concept of the front end.

However I subsequently continued to work on the codebase to drive it to a full playable game.

##Issues encountered

An inherent problem with this exercise was that it doesn't handle multiple instances of the application as specific data related to the instance is not stored within a database and there are limitations on who much information can be stored in sessions.

Hence if this application is opened similtaneously on different browsers, there is conflict.

This could be resolved using databases to store / retrieve the information related to specific sessions, but was beyond the scope of this challenge.

###Technologies

- Ruby
- Sinatra
- HTML
- CSS
- Rspec
- Cucumber
- Capybara

###Screenshot

![alt text](https://github.com/andygnewman/battleships-web/blob/master/Battleships-Screenshot.png "Battleships Screenshot")

###Playing the game

The game is deployed on heroku [Andy's Battleships](http://battleshipsandy.herokuapp.com/ "Andy's Battleships")

or alternatively you can clone the repository, navigate into the top level directory `$ rackup` and open [http://localhost:9292](http://localhost:9292)

###Tests

Unit tested with Rspec `$ rspec`

Feature tested with Cucumber / Capybara `$ cucumber`

*However as cucumber tests are run in parallel, the multiple instance issues noted above create conflicts in the tests. Therefore feature tests need to be run file by file ie.*

`$ cucumber features/registering_players.feature`

`$ cucumber features/placing_ships.feature`

`$ cucumber features/taking_shots.feature`

`$ cucumber features/winning_the_game.feature`
