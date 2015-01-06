Given(/^I am on the new_game page"$/) do 
  visit "/new_game"
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |form_field, name|
  fill_in form_field, with: name
end

When(/^I click "(.*?)"$/) do |submit|
  click_on submit
end

Then(/^player name should be "(.*?)"$/) do |name|
  expect(@name).to eq(name)
end
