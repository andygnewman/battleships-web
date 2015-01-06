class Board

  attr_reader :grid

  def initialize(content = Cell)
    @grid = {}
    columns = [*"A".."J"]
    rows = [*1..10]
    rows.each {|n| columns.each {|l| @grid["#{l}#{n < 10 ? "0" : ""}#{n}".to_sym] = content.new}}
    end

  def place_ship(ship, start_cell, orientation)
    coords = coordinates(ship, start_cell, orientation)
    put_on_grid_if_possible(coords, ship)
  end

  def coordinates(ship, start_cell, orientation)
    coords = [start_cell]
    ((ship.size) -1).times {coords << next_cell(coords, orientation)}
    coords
  end

  def put_on_grid_if_possible(coords, ship)
    within_grid(coords)
    check_coords_for_ships(coords)
    place_ship_in_all_cells(coords, ship)
  end

  def next_cell(coords, orientation)
    orientation == :vertical ? coords.last.next : next_horizontal(coords)
  end

  def next_horizontal(coords)
    coords.last.to_s.reverse.next.reverse.to_sym
  end

  def within_grid(coords)
    raise 'You cannot place a ship outside the grid' unless grid.keys & coords == coords
  end

  def check_coords_for_ships(coords)
    raise 'You cannot place a ship on another ship' if coords.any? { |grid_ref| grid[grid_ref].ship_or_water == :ship}
  end

  def place_ship_in_all_cells(coords, ship)
    coords.each {|grid_ref| place_ship_in_a_cell(grid_ref, ship)}
  end

  def place_ship_in_a_cell(grid_ref, ship)
    grid[grid_ref].ship_in_cell!(ship)
  end

  def cell_object(grid_ref)
    grid[grid_ref]
  end

  # methods below were quickly written to generate a view in the terminal of the grid to assist placing ships and shooting, not intended for use

  def display_own_grid
    hit_values = []
    ship_values = []
     grid.keys.each {|g| hit_values << (grid[g].hit ? "H" : "-")}
     grid.keys.each {|g| ship_values << (grid[g].ship_in_cell ? "S" : "W")}
    display_array = []
    for i in 0..99 
      display_array << "#{grid.keys[i]}#{hit_values[i]}#{ship_values[i]}"
    end
    p display_array[0..9]
    p display_array[10..19]
    p display_array[20..29]
    p display_array[30..39]
    p display_array[40..49]
    p display_array[50..59]
    p display_array[60..69]
    p display_array[70..79]
    p display_array[80..89]
    p display_array[90..99]
  end

  def display_opponent_grid
    hit_values = []
    grid.keys.each {|g| hit_values << (grid[g].hit ? (grid[g].ship_in_cell ? "S" : "M") : "-")}
    display_array = []
    for i in 0..99 
      display_array << "#{grid.keys[i]}#{hit_values[i]}"
    end
    p display_array[0..9]
    p display_array[10..19]
    p display_array[20..29]
    p display_array[30..39]
    p display_array[40..49]
    p display_array[50..59]
    p display_array[60..69]
    p display_array[70..79]
    p display_array[80..89]
    p display_array[90..99]
  end 

end
