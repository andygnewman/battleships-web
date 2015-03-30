#Batleships Web

Building on week two challenge of building the logic of the battleships game in Ruby (we utilised code written by @andygnewman
and @bebbs), the challenge for week three was to bring it to life with a web front end built with Sinatra and utilising
Cucumber / Capybara for test driven development.

This was our first piece of work that encompassed front end.

It was a pairing project between @andygnewman and @emilysas

The challenges we found were;
  - adding a new class to the existing Ruby logic to manage the game play (setting up the players, boards and fleet)
  - rotating players using minimal session cookie data
  - minimising logic within the sinatra code

Additionally this was our first experience of html, so interface was extremely basic.

The depth of challenges we encountered meant little progress towards a final playable game was made during the challenge days.
Though many valuable lessons we learnt in terms of structuring underlying code base to optimise for web interfaces.

Subsequently @andygnewman continued to work on the codebase to drive it to a full playable game.

At it's current state it can be played through to winner status, however the following opportunities for further develoment
exist;
  - implementation of a more sensible game flow through routing control in Sinatra
  - improved integration test coverage in Cucumber / Capybara
  - improved look and feel to design, using layout file an CSS styling
  - use of partials with Sinatra to increase legibility of code
  - refactoring ruby code to differentiate public / private methods and reduce overall number of methods
