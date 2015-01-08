Given(/^I am on get_coordinates$/) do
   visit ("/get_coordinates")
   
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |name, text|
   fill_in(name, :with => text)
end

When(/^I press Submit$/) do
  click_button 'submit'
end

Then(/^the Aircraft Carrier will be placed at "(.*?)" to "(.*?)"$/) do |coord1, coord2|
  expect(page).to have_content "Please enter coordinates for Battleship of size 4"
end
