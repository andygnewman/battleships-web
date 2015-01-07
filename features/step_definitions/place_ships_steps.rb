
Given(/^I am on set_up$/) do
   visit ("/set_up")
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |name, text|
   fill_in(name, :with => text)
end

When(/^I press Submit$/) do
  click_button 'submit'
end

Then(/^the Aircraft Carrier will be placed at A(\d+) to E(\d+)$/) do |arg1, arg2|
  expect(page).to have_content 'Placed ship yay'
end