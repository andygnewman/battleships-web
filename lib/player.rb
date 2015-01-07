require 'board'

class Player

  attr_reader :name, :board, :fleet

  def initialize(player_name, board_content = Board, fleet_content = Fleet)
    player_name_setup(player_name)
    board_setup(board_content)
    fleet_setup(fleet_content)
  end

  def player_name_setup(player_name)
    @name = player_name
  end

  def board_setup(board_content)
    @board = board_content.new
  end

  def fleet_setup(fleet_content)
    @fleet = fleet_content.new
  end

  def receive_shot(grid_ref)
    board.cell_object(grid_ref.to_sym).hit!
    is_fleet_sunk?
  end

  def is_fleet_sunk?
   p "#{name} has lost!" if fleet.sunk?
  end

end