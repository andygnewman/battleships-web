require 'sinatra'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :new_game  
  end

  get '/registered' do
    @player_name = params[:player_name]
    if @player_name.empty?
      erb :need_name
    else
      @player1_name = @player_name
      "Thank you #{@player1_name} for registering"
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
