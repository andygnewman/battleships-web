
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
