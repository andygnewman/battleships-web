Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I follow "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^I am on new_game$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I press "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^there is already a player registered named "(.*?)"$/) do |player_name|
  visit path_to("/new_game")
  fill_in("player_name", :with => player_name)
  click_button("submit")
end

Given(/^players "(.*?)" and "(.*?)" have registered$/) do |player1_name, player2_name|
  visit path_to("/new_game")
  fill_in("player_name", :with => player1_name)
  click_button("submit")
  fill_in("player_name", :with => player2_name)
  click_button("submit")
end
