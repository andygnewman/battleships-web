ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'app/battleships.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = BattleShips

class RpsWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  RpsWorld.new
end
