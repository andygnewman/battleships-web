require 'board'

describe Board do

  let(:board) {Board.new(cell_class)}

  let(:ship_double){double :ship_double}
  let(:cell_class){double :cell_class, new: cell}
  let(:cell){double :cell, content: :water, ship_object: nil}
  let(:cellA1){double :cellA1}
  let(:cellA2){double :cellA2}
  let(:cellA3){double :cellA3}

  context 'a grid when initialised should' do
  
    it 'have 100 cells' do
      expect(board.grid.length).to eq(100)
    end

  end
  
  context 'placing ships methods:' do

    it 'should return the expected coordinates for a vertical ship of size 3' do
      allow(ship_double).to receive(:size).and_return(3)
      expect(board.coordinates(ship_double, :A1, :vertical)).to eq([:A1, :A2, :A3])
    end

    it 'should return the expected coordinates for a vertical ship of size 5' do
      allow(ship_double).to receive(:size).and_return(5)
      expect(board.coordinates(ship_double, :C2, :horizontal)).to eq([:C2, :D2, :E2, :F2, :G2])
    end

    it 'should recognise if a ship is going outside the grid' do
      expect{board.within_grid([:A9, :A10, :A11])}.to raise_error(RuntimeError, 'You cannot place a ship outside the grid')
    end

    it 'should know that the coordinates are clear, if there are no ships' do
      board.grid[:A1], board.grid[:A2], board.grid[:A3] = cellA1, cellA2, cellA3
      allow(cellA1).to receive(:ship_or_water).and_return(:water)
      allow(cellA2).to receive(:ship_or_water).and_return(:water)
      allow(cellA3).to receive(:ship_or_water).and_return(:water)
      expect([:A1, :A2, :A3].all? {|cell| board.grid[cell].ship_or_water == :water}).to be true
    end

    it 'should know that the coordinates aren\'t clear, if there are ships' do
      board.grid[:A1], board.grid[:A2], board.grid[:A3] = cellA1, cellA2, cellA3
      allow(cellA1).to receive(:ship_or_water).and_return(:water)
      allow(cellA2).to receive(:ship_or_water).and_return(:ship)
      allow(cellA3).to receive(:ship_or_water).and_return(:water)  
      expect{board.check_coords_for_ships([:A1, :A2, :A3])}.to raise_error(RuntimeError, 'You cannot place a ship on another ship')
    end

    it 'should be able to place a ship in to a cell' do
      board.grid[:A1] = cellA1
      expect(cellA1).to receive(:ship_in_cell!).with(ship_double)
      board.place_ship_in_a_cell(:A1, ship_double)
    end

    it 'should be able to place a ship in all its coordinates' do
      board.grid[:A1], board.grid[:A2], board.grid[:A3] = cellA1, cellA2, cellA3
      expect(cellA1).to receive(:ship_in_cell!).with(ship_double)
      expect(cellA2).to receive(:ship_in_cell!).with(ship_double)
      expect(cellA3).to receive(:ship_in_cell!).with(ship_double)
      board.place_ship_in_all_cells([:A1, :A2, :A3], ship_double)
    end
 
  end

  context 'integration test for place_ship method' do

    let(:cellC4){double :cellC4, ship_or_water: :water}
    let(:cellD4){double :cellD4, ship_or_water: :water}
    let(:cellE4){double :cellE4, ship_or_water: :water}
    let(:cellF4){double :cellF4, ship_or_water: :water}

    it 'should place a ship in the cells when passed ship, start cell and orientation' do
      board.grid[:C4], board.grid[:D4], board.grid[:E4], board.grid[:F4] = cellC4, cellD4, cellE4, cellF4
      allow(ship_double).to receive(:size).and_return(4)
      expect(cellC4).to receive(:ship_in_cell!).with(ship_double)
      expect(cellD4).to receive(:ship_in_cell!).with(ship_double)
      expect(cellE4).to receive(:ship_in_cell!).with(ship_double)
      expect(cellF4).to receive(:ship_in_cell!).with(ship_double)
      board.place_ship(ship_double, :C4, :horizontal)
    end

  end

end
