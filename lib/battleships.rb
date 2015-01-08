require 'active_support/all'
require 'sinatra'
require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'cell'
require_relative 'ship'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }
  enable :sessions

  get '/' do
    erb :index
  end

  get '/new_game' do
    game = Game.new
    session[:players] = []
    session[:fleets] = []
    erb :player_reg_form
  end

  post '/registered' do
    if params[:player_name].empty?
      erb :player_reg_form
    else
      player = Player.new
      player.name = params[:player_name]
      session[:players] << player.name
      player.board = Board.new(Cell)
      fleet = [Ship.aircraft_carrier, Ship.battleship, Ship.destroyer, Ship.submarine, Ship.patrol_boat ]
      #session[:fleets] << player.fleet.ship_array
      # puts session.inspect
      if session[:players].size ==2
         erb :register_complete
      else
        erb :player_reg_form
      end
    end
  end

  get '/set_up_fleet' do
    session[:fleet] = session[:fleets].shift
    redirect '/get_coordinates'
  end

  get '/get_coordinates/?:error?' do
    if session[:fleet].size > 0
      session[:ship] = session[:fleet].shift
      @ship = session[:ship]
      @error = params[:error]
      erb :get_coordinates, locals: {ship: @ship, error: @error}
    else
      "You have placed all your ships"
      redirect '/set_up_fleet' if session[:fleets] < 0
    end
  end

  get '/place_ship' do
    if params
      start_cell = params[:start_cell]
      orientation = params[:orientation]
      player = ObjectSpace._id2ref(session[:players][0])
      ship = session[:ship]
      begin
        player.board.place_ship(ship, start_cell.to_sym, orientation.to_sym)
        redirect '/get_coordinates' # erb :place_success
      rescue RuntimeError
        erb :place_error
      end
    end
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
