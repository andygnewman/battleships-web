
Given(/^there is already a player registered named "(.*?)"$/) do |player_name|
  visit path_to("/new_game")
  fill_in("player_name", :with => player_name)
  click_button("submit")
end