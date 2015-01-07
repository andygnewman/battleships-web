require 'sinatra'
require_relative 'player'
require_relative 'fleet'

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
      session[:player_name1] = Player.new(params[:player_name])
      erb :player2
    end
  end

  get '/registered2' do
    session[:player_name2] = params[:player_name]
    if session[:player_name2].empty?
      erb :player2
    else
      session[:player_name2] = Player.new(params[:player_name])
      erb :register_complete 
    end
  end

  get '/set_up' do
    erb :set_up
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
