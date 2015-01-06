require 'sinatra'
# require 'sinatra'

# set :root, File.join(File.dirname(__FILE__), '..')


class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
