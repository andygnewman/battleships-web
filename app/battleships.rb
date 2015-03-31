require 'active_support/all'
require 'sinatra'
require 'rack-flash'
require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'cell'
require_relative 'ship'
require_relative 'fleet'

class BattleShips < Sinatra::Base

  set :root, File.dirname(__FILE__)

  enable :sessions
  use Rack::Flash
  use Rack::MethodOverride

  game = Game.new

  set :game, game

  get '/' do
    session[:grid_display], session[:placing_ships] = false
    erb :index
  end

  get '/new_game' do
    game.fleets.clear
    game.players.clear
    redirect to('/')
  end

  get '/register' do
    @player_number = game.players.size + 1
    session[:placing_ships] = false
    erb :register
  end

  post '/register' do
    game.add_player(params[:player_name])
    game.switch_turns
    redirect to('/place_ship')
  end

  get '/place_ship' do
      session[:placing_ships] = true
      if game.fleet_empty?
        erb :all_fleet_ships_placed
      else
      @current_player = game.current_player
      @ship = game.ship_to_place
      @ship_type = @ship.type.to_s.titleize
      @ship_size = @ship.size
      erb :place_ship
      end
  end

  post '/place_ship' do
      start_cell = params[:row]+params[:column]
      orientation = params[:orientation]
      begin
        game.place_ship(start_cell, orientation)
        game.remove_placed_ship_from_fleet
      rescue => error
        flash[:notice] = error.to_s
      end
      redirect '/place_ship'
  end

  get '/ready_to_play' do
    session[:placing_ships] = false
    game.switch_turns
    @current_player = game.current_player
    erb :ready_to_play
  end

  get '/take_shot' do
    @current_player = game.current_player
    session[:grid_display] = true
    erb :take_shot
  end

  get '/take_shot_interstitial' do
    @current_player = game.current_player
    erb :take_shot_interstitial
  end

  post '/shot_result' do
    target_cell = params[:row]+params[:column]
    begin
      @shot_result = game.shoots(target_cell)
    rescue => error
      flash[:notice] = error.to_s
      redirect '/take_shot'
    end
    erb :shot_result
  end

  get '/next_player_turn' do
    game.switch_turns
    session[:grid_display] = false
    redirect '/take_shot_interstitial'
  end

  get '/winner' do
    @winner = game.current_player
    erb :winner
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
