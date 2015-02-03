class Player
	attr_accessor :name, :board

	def has_board?
		!@board.nil?
	end

  def receive_shot(grid_ref)
    board.shoot_at(grid_ref.to_sym)
    is_fleet_sunk?
  end

end