class Game
	attr_accessor :players, :fleets
	attr_writer :turn

	def initialize
		@fleets = []
		@players = []
	end

	def add_player(player)
		new_player = Player.new
		new_player.name = player
		new_player.board = Board.new(Cell)
		@players << new_player
		@fleets << Fleet.new.ship_array
	end

	# def add_fleet(fleet)
	# 	@fleets << fleet
	# end

	def has_a_player?
		@players.count > 0
	end

	def has_two_players?
		@players.count == 2
	end

	def return_other_player_name(current_player)
		@players.reject { |player| player.name == current_player }.first.name
	end

	def which_is(current_player)
		@players.select { |player| player.name == current_player }.first
	end

	def fleet_empty_for(player)
		fleets[index_for(player)].empty?
	end

	def ship_to_place(player)
		fleets[index_for(player)][0]
	end

	def remove_placed_ship_from_fleet(player)
		fleets[index_for(player)].shift
	end

	# def add_player(player)
	# 	self.player1 ? self.player2 = player : self.player1 = player unless has_two_players?
	# end

	# def opponent
	# 	current_player == player1 ? player2 : player1
	# end

	def shoots(coord)
		opponent.receive_shot(coord)
		raise "There is a winner you cannot shoot" if winner
		switch_turns 
	end

	def winner
		current_player unless opponent.board.floating_ships?
	end

	def ready_to_play?
		has_two_players? and both_players_have_boards? and all_ships_placed?
	end

	def turn 
		@turn ||= player1
	end

	# alias :current_player :turn

private 

	def both_players_have_five_ships?
		(player1.board.ships_count == 5) and (player2.board.ships_count == 5) 
	end

	def both_players_have_boards?
		player1.has_board? and player2.has_board? 
	end

	def switch_turns
		turn == player1 ? self.turn = player2 : self.turn = player1
	end

	def all_ships_placed
		@fleets.empty?
	end

	def index_for(current_player)
		@players.index(@players.select { |player| player.name == current_player }.first)
	end

	# def has_two_players?
	# 	!player2.nil?
	# end
end