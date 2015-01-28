class Board
	attr_reader :grid

	def initialize(content)
    @grid = {}
    columns = [*"A".."J"]
    rows = [*1..10]
    rows.each {|n| columns.each {|l| @grid["#{l}#{n < 10 ? "0" : ""}#{n}".to_sym] = content.new}}
	end

  def place(ship, start_cell, orientation)
    start_cell = start_cell[0] + "0" + start_cell[1] if start_cell.length == 2
    coords = coordinates(ship, start_cell, orientation)
    put_on_grid_if_possible(coords, ship)
  end

	def is_fleet_sunk?
		ships.any?(&:floating?) ? false : true
	end

	def shoot_at(grid_ref)
    grid_ref_sym = grid_ref.to_sym
		raise 'You can\'t shoot outside the grid.' if !grid.keys.include?(grid_ref_sym)
    cell_object(grid_ref_sym).hit!
	end

  def shot_result(grid_ref)
    grid_ref_sym = grid_ref.to_sym
    cell_object(grid_ref_sym).ship_in_cell? ? cell_object(grid_ref_sym).hit_ship_message : "Miss!"
  end

	def ships 
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:ship_object).uniq
	end

	def ships_count
		ships.count
	end

	def cell_object(grid_ref)
		grid[grid_ref]
	end

	def display_players_board
    display_array = []
    grid.keys.each  do |g| 
    display_array << case 
        when cell_object(g).hit && cell_object(g).ship_in_cell? then "S"
        when cell_object(g).hit && !cell_object(g).ship_in_cell? then "M"
        when !cell_object(g).hit && cell_object(g).ship_in_cell? then "s"
        else "w"
      end
    end
    display_array
  end

  def display_opponents_board
    display_array = []
    grid.keys.each {|g| display_array << (grid[g].hit ? (grid[g].ship_in_cell? ? "S" : "M") : "-")}
    display_array
  end

private

 	def coordinates(ship, start_cell, orientation)
    coords = [start_cell]
    ((ship.size) -1).times {coords << next_cell(coords, orientation)}
    coords
  end

 	def next_cell(coords, orientation)
		orientation == :vertical ? coords.last.next : next_horizontal(coords)
	end

  def next_horizontal(coords)
    coords.last.to_s.reverse.next.reverse.to_sym
  end

	def is_a_ship?(cell)
		cell.ship_in_cell?
	end

  def put_on_grid_if_possible(coords, ship)
    within_grid(coords)
    check_coords_for_ships(coords)
    place_ship_in_all_cells(coords, ship)
  end

  def within_grid(coords)
    raise 'You cannot place a ship outside the grid' unless grid.keys & coords == coords
  end

  def check_coords_for_ships(coords)
    raise 'You cannot place a ship on another ship' if coords.any? { |grid_ref| grid[grid_ref].ship_in_cell?}
  end

  def place_ship_in_all_cells(coords, ship)
    coords.each {|grid_ref| place_ship_in_a_cell(grid_ref, ship)}
  end

  def place_ship_in_a_cell(grid_ref, ship)
    grid[grid_ref].ship_in_cell!(ship)
  end


end

