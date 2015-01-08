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
  game = Game.new
  fleet1 = Fleet.new.ship_array
  fleet2 = Fleet.new.ship_array
  players = []

  get '/' do
    erb :index
  end

  get '/new_game' do
    players.clear
    @player_to_register = players.size + 1
    erb :player_reg_form, locals: {player_to_register: @player_to_register}
  end

  post '/registered' do
    if params[:player_name].empty?
      @player_to_register = players.size + 1
      erb :player_reg_form, locals: {player_to_register: @player_to_register}
    else
      player = Player.new
      player.name = params[:player_name]
      player.board = Board.new(Cell)
      players << player
      if players.size ==2
         @player1_name = players[0].name
         @player2_name = players[1].name
         erb :register_complete, locals: {player1_name: @player1_name, player2_name: @player2_name}
      else
        @player_to_register = players.size + 1
        erb :player_reg_form, locals: {player_to_register: @player_to_register}
      end
    end
  end

  get '/get_coordinates/?:error?' do
    puts fleet1
    fleet1.empty? ? fleet = fleet2 : fleet = fleet1
    if fleet.length >= 1
      session[:ship] = fleet.shift
      @ship = session[:ship]
      @error = params[:error]
      erb :get_coordinates, locals: {ship: @ship, error: @error}
    else
      "You have placed all your ships"
      # redirect '/set_up_fleet' if fleet == 0
    end
  end

  get '/place_ship' do
    if params
      start_cell = params[:start_cell]
      orientation = params[:orientation]
      player = players[0]
      ship = session[:ship]
      begin
        player.board.place(ship, start_cell.to_sym, orientation.to_sym)
        redirect '/get_coordinates' # erb :place_success
      rescue RuntimeError
        erb :place_error
      end
    end
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
