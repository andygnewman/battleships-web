require_relative '../app/board.rb'

describe Board do

  let(:board) {Board.new(cell_class)}

  let(:ship_double){double :ship_double, floating?: true}
  let(:ship_double_sunk){double :ship_double_sunk, floating?: false}
  let(:cell_class){double :cell_class, new: cell}
  let(:cell){double :cell, ship_object: nil, hit: false, ship_in_cell?: false}
  let(:cell_hit){double :cell, hit: true, ship_in_cell?: false}
  let(:cell_hit_ship){double :cell, ship_in_cell?: true, hit: true}
  let(:cell_sunk_ship){double :cell, ship_in_cell?: true, ship_object: ship_double_sunk}

  context 'a grid when initialised should' do

    it 'have 100 cells' do
      expect(board.grid.length).to eq(100)
    end

  end

  context 'calculating coordinates for placing ships:' do

    it 'should return the expected coordinates for a vertical ship of size 3' do
      allow(ship_double).to receive(:size).and_return(3)
      expect(board.coordinates(ship_double, :A01, :vertical)).to eq([:A01, :B01, :C01])
    end

    it 'should return the expected coordinates for a vertical ship of size 5' do
      allow(ship_double).to receive(:size).and_return(5)
      expect(board.coordinates(ship_double, :C02, :horizontal)).to eq([:C02, :C03, :C04, :C05, :C06])
    end

  end

  context 'placing ships - where not allowed' do

    it 'should recognise if a ship is going outside the grid' do
      allow(ship_double).to receive(:size).and_return(3)
      expect{board.place(ship_double, "A9", :horizontal)}.to raise_error(RuntimeError, 'You cannot place a ship outside the grid')
    end

    it 'should recognise if trying to place a ship on another ship' do
      allow(ship_double).to receive(:size).and_return(3)
      allow(board.grid[:C04]).to receive(:ship_in_cell?).and_return(true)
      expect{board.place(ship_double, "C3", :vertical)}.to raise_error(RuntimeError, 'You cannot place a ship on another ship')
    end

  end

  context 'shooting at cells' do

    it 'should not allow a shot outside the grid' do
      expect{board.shoot_at("A11")}.to raise_error(RuntimeError, "You can't shoot outside the grid")
    end

  end

  context 'fleet status' do

    it 'should know when the fleet is sunk' do
      allow(board.grid[:A01]).to receive(:ship_in_cell?).and_return(true)
      allow(board.grid[:A01]).to receive(:ship_object).and_return(ship_double_sunk)
      expect(board.is_fleet_sunk?).to be(true)
    end

    it 'should know when the fleet is not sunk' do
      allow(board.grid[:A01]).to receive(:ship_in_cell?).and_return(true)
      allow(board.grid[:A01]).to receive(:ship_object).and_return(ship_double)
      expect(board.is_fleet_sunk?).to be(false)
    end

  end

  context 'score status' do

    it 'should know how many shots have been received on the board' do
      board.grid[:A01] = cell_hit
      board.grid[:D05] = cell_hit
      expect(board.shots_received).to eq(2)
    end

    it 'should know how many ship hits have been suffered' do
      board.grid[:A01] = cell_hit
      board.grid[:D05] = cell_hit_ship
      expect(board.ship_hits_suffered).to eq(1)
    end

    it 'should know how many ships are sunk' do
      board.grid[:D05] = cell_sunk_ship
      expect(board.ships_sunk).to eq(1)
    end

  end

end
