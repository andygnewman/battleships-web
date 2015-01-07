require 'active_support/all'
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
    player = session[:player_name1]
    @fleet = player.fleet.ship_array
    erb :set_up, locals: {fleet: @fleet}
  end

  post '/place_ship' do
    if params.length == 2
      start_cell = params[:start_cell]
      orientation = params[:orientation]
      player = session[:player_name1]
      begin
        player.board.place_ship(player.fleet.ship_array[0], start_cell.to_sym, orientation.to_sym)
        "Placed ship yay"
      rescue RuntimeError
        "Ship cant go here"
      end
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
