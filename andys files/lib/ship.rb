class Ship

  SHIPS = {aircraft_carrier: 5, battleship: 4, submarine: 3, destroyer: 3, patrol_boat: 2}

  def initialize(size, type)
    @size = size
    @type = type
    @hits_received = 0
  end

  attr_reader :type, :size, :hits_received

  def self.method_missing name, *args
    return new SHIPS[name], name if SHIPS[name]
    super
  end

  def hit!
    @hits_received += 1
  end

  def sunk?
    hits_received == size
  end

end