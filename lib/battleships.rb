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
    if session[:current_player]
      @current_player = session[:current_player]
    end
    erb :index
  end

  get '/new_game' do
    GAME.fleets.clear
    GAME.players.clear
    redirect to('/')
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
      session[:current_player] = GAME.opponent_name(session[:current_player])
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
        redirect '/get_coordinates' 
      rescue => error
        session[:error] = error.to_s
        redirect '/get_coordinates/error'
      end
    end
  end

  get '/play_the_game' do
    if GAME.has_two_players? && (GAME.fleet_empty_for(session[:current_player]) && GAME.fleet_empty_for(GAME.opponent_name(session[:current_player])))
      redirect '/take_shot'
    else
      redirect '/'
    end
  end

  get '/take_shot/?:error?' do
    @error = session[:error] if params[:error] != nil
    erb :take_shot
  end

  get '/shot_result/?:error?' do
    if params[:target_cell]
      begin
        GAME.opponent_object(session[:current_player]).board.shoot_at(params[:target_cell])
      rescue => error
        session[:error] = error.to_s
        redirect '/take_shot/error'
      end
      erb :shot_result
    else
      session[:error] = 'You need to enter a target cell'
      redirect '/take_shot/error'
    end
  end

  get '/shot_result' do
    erb :shot_result
  end

  get '/next_player_turn' do
    session[:current_player] = GAME.opponent_name(session[:current_player])
    redirect '/take_shot'
  end


  get '/players_board' do
    @player = GAME.which_is(session[:current_player])
    erb :_players_board
  end

  get '/opponents_board' do
    @player = GAME.which_is(session[:current_player])
    erb :_opponents_board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
