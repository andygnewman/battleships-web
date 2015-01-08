# class Cell

#   attr_reader :hit, :ship_object

#   def initialize 
#     @hit = false
#     @ship_object = nil
#   end

#   def hit!
#     raise 'This cell has already been hit.' if hit
#     @hit = true
#     ship_in_cell ? hit_ship_actions : (p 'You missed!')
#   end

#   def hit_ship_actions
#     ship_object.hit!
#     hit_ship_message
#   end

#   def ship_in_cell!(ship) 
#     @ship_object = ship
#   end

#   def ship_in_cell
#     ship_object != nil
#   end
  
#   def ship_or_water
#     ship_object != nil ? :ship : :water
#   end

#   def hit_ship_message
#       p (ship_object.sunk?) ? "You sank my #{ship_object.type}!" : "You hit my #{ship_object.type}!"
#   end

# end