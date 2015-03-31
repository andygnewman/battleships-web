Given(/^I am on the homepage$/) do
  visit '/'
  click_on 'new game'
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Given(/^I am ready to register the first player$/) do
  visit '/'
  click_on 'new game'
  click_on "Register Player 1"
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

Given(/^I click "(.*?)"$/) do |button|
  click_on button
end

Given(/^I have registered the first player$/) do
  visit '/'
  click_on 'new game'
  click_on "Register Player 1"
  fill_in 'player_name', with: "Andy"
  click_on 'submit'
end

Given(/^I place a ship in column "(.*?)" row "(.*?)" orientation "(.*?)"$/) do |c, r, o|
  select c, from: "column"
  select r, from: "row"
  choose o
  click_on 'submit'
end

Given(/^I have placed all ships$/) do
  # [*"A".."E"].each do |c|
  #   select c, from: "column"
  #   select "1", from: "row"
  #   choose "horizontal"
  #   click_on 'submit'
  # end
  place_all_ships
end

Given(/^I have registered the second player$/) do
  click_on "Click here to register Player 2"
  fill_in 'player_name', with: "Josh"
  click_on 'submit'
end

Given(/^registration and placement completed$/) do
  pending # express the regexp above with the code you wish you had
end
