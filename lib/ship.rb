class Ship
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
		true
	end

	def sunk?
		hits == size
	end

	def floating?
		!sunk?
	end

	# def self.aircraft_carrier
	# 	new 5
	# end

	# def self.battleship
	# 	new 4
	# end

	# def self.destroyer
	# 	new 3
	# end

	# def self.submarine
	# 	new 3
	# end

	# def self.patrol_boat
	# 	new 5
	# end

end