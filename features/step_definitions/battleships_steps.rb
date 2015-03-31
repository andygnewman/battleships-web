Given(/^I am on the homepage$/) do
  visit '/'
  click_on 'new game'
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Given(/^I am ready to register the first player$/) do
  ready_to_register_player_1
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

Given(/^I click "(.*?)"$/) do |button|
  click_on button
end

Given(/^I have registered the first player$/) do
  ready_to_register_player_1
  register_player_1
end

Given(/^I place a ship in column "(.*?)" row "(.*?)" orientation "(.*?)"$/) do |c, r, o|
  select c, from: "column"
  select r, from: "row"
  choose o
  click_on 'submit'
end

Given(/^I have placed all ships$/) do
  place_all_ships
end

Given(/^I have registered the second player$/) do
  register_player_2
end

Given(/^registration and placement completed$/) do
  register_and_place_ships
  ready_for_battle
end

Given(/^I shoot at column "(.*?)" row "(.*?)"$/) do |c, r|
  take_a_shot(c,r)
end

Given(/^a round of shots has been completed column "(.*?)" row "(.*?)"$/) do |c, r|
  take_a_shot(c,r)
  next_player_shot
  take_a_shot(c,r)
  next_player_shot
end

Given(/^we have taken shots at all ships$/) do
  register_and_place_ships
  ready_for_battle
  sink_fleet
end
