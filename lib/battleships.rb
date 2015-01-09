require 'active_support/all'
require 'sinatra'
require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'cell'
require_relative 'ship'
require_relative 'fleet'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }
  enable :sessions
  
  GAME = Game.new

  get '/' do
    erb :index
  end

  get '/new_game' do
    GAME.fleets.clear
    GAME.players.clear
    erb :index
  end

  get '/register' do
    if GAME.has_two_players?
      @msg = "You already have 2 players registered, either place ships or start game"
      erb :index, locals: {msg: @msg }
    else
      if params[:player_name]
      GAME.add_player(params[:player_name])
      session[:current_player] = params[:player_name]
      GAME.has_two_players? ? (erb :register_complete) : (erb :index)
      else
        erb :player_reg_form      
      end
    end
  end

  get '/switch_players' do
    if GAME.has_two_players? 
      puts GAME.return_other_player_name(session[:current_player])
      session[:current_player] = GAME.return_other_player_name(session[:current_player])
    else
      @msg = "You need to have two players registered before you can switch"
      erb :index, locals: {msg: @msg }     
    end
      erb :index
  end


  get '/get_coordinates/?:error?' do
    if session[:current_player]
      if GAME.fleet_empty_for(session[:current_player])
        erb :all_fleet_ships_placed
      else
      @ship = GAME.ship_to_place(session[:current_player])
      @ship_type = @ship.type.to_s.titleize
      @ship_size = @ship.size
      @error = session[:error] if params[:error] != nil
      erb :get_coordinates, locals: {ship: @ship, error: @error, ship_type: @ship_type, ship_size: @ship_size}
      end
    else
      @msg = "You need to register before you can place ships"
      erb :index, locals: {msg: @msg } 
    end     
  end

  get '/place_ship' do
    if params
      start_cell = params[:start_cell]
      orientation = params[:orientation]
      player = GAME.which_is(session[:current_player])
      ship = GAME.ship_to_place(session[:current_player])
      begin
        player.board.place(ship, start_cell.to_sym, orientation.to_sym)
        GAME.remove_placed_ship_from_fleet(session[:current_player])
        redirect '/get_coordinates' # erb :place_success
      rescue => error
        session[:error] = error.to_s
        puts session[:error]
        redirect '/get_coordinates/error'
      end
    end
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
