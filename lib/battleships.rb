require 'sinatra'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :player1  
  end

  get '/registered' do
    @players ||= []
    @player_name = params[:player_name]

    if @player_name.empty?
      erb :need_name
    else
      @players << @player_name
      if @players.length < 2
        erb :player2
      else
        "Thank you #{@players[1]}, you will be playing against #{@players[0]}"
      end
    end
    # elsif @players == []
    #   @players << @player_name
    #   erb :player2
    
      # "Thank you #{@players[1]}, you will be playing against #{@players[0]}"
    # end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
