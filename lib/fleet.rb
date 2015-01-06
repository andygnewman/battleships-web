class Fleet

  attr_reader :ship_array

  def initialize
    @ship_array = []
    create_ships
  end

  def create_ships
    @ship_array << Ship.aircraft_carrier
    @ship_array << Ship.battleship
    2.times {@ship_array << Ship.destroyer}
    @ship_array << Ship.submarine
    4.times {@ship_array << Ship.patrol_boat}
  end

  def sunk?
    ship_array.each { |ship| return false if !ship.sunk? }
  end

end