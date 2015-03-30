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

  GAME = Game.new

  get '/' do
    session[:grid_display], session[:placing_ships] = false
    erb :index
  end

  get '/new_game' do
    GAME.fleets.clear
    GAME.players.clear
    redirect to('/')
  end

  get '/register' do
    session[:placing_ships] = false
    erb :register
  end

  post '/register' do
    GAME.add_player(params[:player_name])
    GAME.switch_turns
    redirect to('/place_ship')
  end

  get '/place_ship' do
      session[:placing_ships] = true
      if GAME.fleet_empty?
        erb :all_fleet_ships_placed
      else
      @ship = GAME.ship_to_place
      @ship_type = @ship.type.to_s.titleize
      @ship_size = @ship.size
      erb :place_ship
      end
  end

  post '/place_ship' do
      start_cell = params[:column]+params[:row]
      orientation = params[:orientation]
      begin
        GAME.place_ship(start_cell, orientation)
        GAME.remove_placed_ship_from_fleet
      rescue => error
        flash[:notice] = error.to_s
      end
      redirect '/place_ship'
  end

  get '/ready_to_play' do
    session[:placing_ships] = false
    GAME.switch_turns
    erb :ready_to_play
  end

  get '/take_shot' do
    session[:grid_display] = true
    erb :take_shot
  end

  get '/take_shot_interstitial' do
    erb :take_shot_interstitial
  end

  post '/shot_result' do
    @target_cell = params[:column]+params[:row]
    begin
      GAME.shoots(@target_cell)
    rescue => error
      flash[:notice] = error.to_s
      redirect '/take_shot'
    end
    erb :shot_result
  end

  get '/next_player_turn' do
    GAME.switch_turns
    session[:grid_display] = false
    redirect '/take_shot_interstitial'
  end

  get '/winner' do
    erb :winner
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
