class Player
	attr_reader :name, :board

	def set_name(name)
		@name = name
	end

	def set_board(board)
		@board = board
	end

	def has_board?
		!@board.nil?
	end

end
