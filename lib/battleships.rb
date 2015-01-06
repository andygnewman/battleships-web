require 'sinatra'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :player1  
  end

  get '/registered1' do
    @player_name1 = params[:player_name]
    if @player_name1.empty?
      erb :player1
    else
      erb :player2
    end
  end

  get '/registered2' do
    @player_name2 = params[:player_name]
    if @player_name2.empty?
      erb :player2
    else
      "Thank you #{@player_name2}, you will be playing against #{@player_name1}"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
