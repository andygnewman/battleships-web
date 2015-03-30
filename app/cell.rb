class Cell
 attr_reader :hit, :ship_object

  def initialize
    @hit = false
    @ship_object = nil
  end

  def hit!
    raise 'This cell has already been hit.' if hit
    @hit = true
    ship_in_cell? ? ship_object.hit! : "You missed!"
  end

  def ship_in_cell!(ship)
    @ship_object = ship
  end

  def ship_in_cell?
    ship_object != nil
  end

  def ship_initial
    ship_type_in_cell.chars.first
  end

  private

  def ship_type_in_cell
    ship_object.type
  end

end
