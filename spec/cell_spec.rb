require_relative '../app/cell.rb'

describe Cell do

let(:cell){Cell.new}
let(:ship_double){double :ship_double}

  context 'a cell when initialised should:' do

    it 'contain not contain a ship' do
      expect(cell.ship_in_cell?).to be(false)
    end

    it 'not be hit' do
      expect(cell.hit).to eq(false)
    end

  end

  context 'a cell can be:' do

    before(:each) {cell.hit!}

    it 'hit' do
      expect(cell.hit).to be true
    end

    it 'hit only once' do
      expect{cell.hit!}.to raise_error(RuntimeError, 'This cell has already been hit.')
    end

  end

  context 'when receiving a shot' do

    it 'on a cell with a ship in it, return a you hit a ship message' do
      cell.ship_in_cell!(ship_double)
      allow(ship_double).to receive(:hit!).and_return('You hit my battleship!')
      expect(cell.hit!).to eq('You hit my battleship!')
    end

# this test is focused on functionality of ship, should test there

    xit 'and sinking a ship, return you sunk a ship message' do
      cell.ship_in_cell!(ship_double)
      allow(ship_double).to receive(:hit!)
      allow(ship_double).to receive(:sunk?).and_return(true)
      allow(ship_double).to receive(:type).and_return('patrol_boat')
      expect(cell.hit!).to eq('You sank my patrol_boat!')
    end

    it 'on a cell with no ship in it, return a you missed message' do
      expect(cell.hit!).to eq('You missed!')
    end

  end

  context 'receiving ships' do

    it 'should be capable of receiving a ship in it' do
      cell.ship_in_cell!(ship_double)
      expect(cell.ship_in_cell?).to be(true)
    end

  end

  context 'receiving a specific ship' do

    before(:each) {cell.ship_in_cell!(ship_double)}

    it 'should know which ship object is placed in it' do
      expect(cell.ship_object).to eq(ship_double)
    end

    it 'should know the initial of the type of ship placed in it' do
      allow(ship_double).to receive(:type).and_return('aircraft_carrier')
      expect(cell.ship_initial).to eq('a')
    end

  end

end
