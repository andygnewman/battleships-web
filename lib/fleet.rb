require_relative 'ship'

class Fleet

  attr_reader :ship_array

  def initialize
    @ship_array = [Ship.aircraft_carrier, Ship.battleship, Ship.destroyer, Ship.destroyer, Ship.submarine, Ship.patrol_boat, Ship.patrol_boat, Ship.patrol_boat, Ship.patrol_boat]
  end


  def sunk?
    ship_array.each { |ship| return false if !ship.sunk? }
  end

end