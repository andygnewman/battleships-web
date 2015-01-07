require 'sinatra'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }
  enable :sessions

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :player1  
  end

  get '/registered1' do
    session[:player_name1] = params[:player_name]
    if session[:player_name1].empty?
      erb :player1
    else
      erb :player2
    end
  end

  get '/registered2' do
    session[:player_name2] = params[:player_name]
    if session[:player_name2].empty?
      erb :player2
    else
      erb :register_complete
      
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
