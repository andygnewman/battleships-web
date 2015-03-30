class Game
	attr_accessor :players, :fleets
	attr_writer :turn

	def initialize
		@fleets = []
		@players = []
	end

	def add_player(player)
		new_player = Player.new
		new_player.set_name(player)
		new_player.set_board(Board.new(Cell))
		@players << new_player
		@fleets << Fleet.new.ship_array
	end

	def has_two_players?
		players.count == 2
	end

	def opponent_name
		players.reject { |player| player.name == current_player }.first.name
	end

	def shots_received(player_index)
		players[player_index].board.shots_received
	end

	def ship_hits_suffered(player_index)
		players[player_index].board.ship_hits_suffered
	end

	def ships_sunk(player_index)
		players[player_index].board.ships_sunk
	end

	def fleet_empty?
		fleets[index_current_player].empty?
	end

	def ship_to_place
		fleets[index_current_player].first
	end

	def place_ship(start_cell, orientation)
		current_player_object.board.place(ship_to_place, start_cell, orientation)
	end

	def remove_placed_ship_from_fleet
		fleets[index_current_player].shift
	end

	def opponents_board
		opponent_object.board.display_opponents_board
	end

	def players_board
		current_player_object.board.display_players_board
	end

	def shoots(target_cell)
		opponent_object.board.shoot_at(target_cell)
	end

	def shot_result(target_cell)
		opponent_object.board.shot_result(target_cell)
	end

	def winner?
		opponent_object.board.is_fleet_sunk?
	end

	def turn
		@turn ||= players.first.name
	end

	alias :current_player :turn

	def switch_turns
		turn == players.first.name ? self.turn = players.last.name : self.turn = players.first.name if has_two_players?
	end

private

	def index_current_player
		players.index(players.select { |player| player.name == current_player }.first)
	end

	def opponent_object
		players.reject { |player| player.name == current_player }.first
	end

	def current_player_object
		players.select { |player| player.name == current_player }.first
	end

end
