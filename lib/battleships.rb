require 'sinatra/base'

class BattleShips < Sinatra::Base
  get '/' do
    'Hello BattleShips!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
