class Board
	attr_reader :grid

	def initialize(content)
    @grid = {}
    columns = [*1..10]
    rows = [*"A".."J"]
    rows.each {|l| columns.each {|n| @grid["#{l}#{n < 10 ? "0" : ""}#{n}".to_sym] = content.new}}
	end

  def place(ship, grid_ref, orientation)
    start_cell = normalize_grid_ref(grid_ref)
    coords = coordinates(ship, start_cell, orientation.to_sym)
    put_on_grid_if_possible(coords, ship)
  end

	def is_fleet_sunk?
		ships.any?(&:floating?) ? false : true
	end

	def shoot_at(grid_ref)
    grid_ref = normalize_grid_ref(grid_ref)
		raise 'You can\'t shoot outside the grid.' if !grid.keys.include?(grid_ref)
    grid[grid_ref].hit!
	end

  def shot_result(grid_ref)
    grid_ref = normalize_grid_ref(grid_ref)
    grid[grid_ref].ship_in_cell? ? grid[grid_ref].hit_ship_message : "Miss!"
  end

  def shots_received
    grid.values.select{|cell|is_hit?(cell)}.length
  end

  def ship_hits_suffered
    grid.values.select{|cell| (is_hit?(cell) && cell.ship_in_cell?) }.length
  end

  def ships_sunk
    ships.reject(&:floating?).count
  end

	def cell_object(grid_ref)
		grid[grid_ref]
	end

	def display_players_board
    display_array = []
    grid.keys.each {|g| display_array << (grid[g].hit ? (grid[g].ship_in_cell? ? "S" : "M") : (grid[g].ship_in_cell? ? "s" : "-"))}
    display_array
	end

  def display_opponents_board
    display_array = []
    grid.keys.each {|g| display_array << (grid[g].hit ? (grid[g].ship_in_cell? ? "S" + grid[g].ship_initial : "M") : "-")}
    display_array
  end

private

	def coordinates(ship, start_cell, orientation)
    coords = [start_cell]
    ((ship.size) -1).times {coords << next_cell(coords, orientation)}
    coords
	end

 	def next_cell(coords, orientation)
		orientation == :horizontal ? coords.last.next : next_vertical(coords)
	end

  def next_vertical(coords)
    coords.last.to_s.reverse.next.reverse.to_sym
  end

  def is_hit?(cell)
    cell.hit
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

  def ships
    grid.values.select{|cell|cell.ship_in_cell?}.map(&:ship_object).uniq
  end

  def normalize_grid_ref(grid_ref)
    normalized_grid_ref = grid_ref[0] + "0" + grid_ref[1] if grid_ref.length == 2
    return normalized_grid_ref.to_sym
  end

end
