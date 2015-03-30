class Ship

	require 'active_support/all'

	attr_reader :size, :type
	attr_accessor :hits

  SHIPS = {aircraft_carrier: 5, battleship: 4, submarine: 3, destroyer: 3, patrol_boat: 2}

  def self.method_missing name, *args
    return new SHIPS[name], name if SHIPS[name]
    super
  end

	def initialize(size, type)
		@size, @hits, @type = size, 0, type
	end

	def hit!
		self.hits += 1
		hit_ship_message
	end

	def sunk?
		hits == size
	end

	def floating?
		!sunk?
	end

	def hit_ship_message
		self.sunk? ? "You sank my #{type.to_s.titleize}!" : "You hit my #{type.to_s.titleize}!"
	end

end
