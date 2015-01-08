require 'cell'

describe Cell do

let(:cell){Cell.new}
let(:ship_double){double :ship_double}

  context 'a cell when initialised should:' do
    
    it 'contain water' do
      expect(cell.ship_or_water).to eq(:water)
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
      allow(ship_double).to receive(:hit!)
      allow(ship_double).to receive(:sunk?).and_return(false)
      allow(ship_double).to receive(:type).and_return('battleship')
      expect(cell.hit!).to eq('You hit my battleship!')
    end

    it 'and sinking a ship, return you sunk a ship message' do
      cell.ship_in_cell!(ship_double)
      allow(ship_double).to receive(:hit!)
      allow(ship_double).to receive(:sunk?).and_return(true)
      allow(ship_double).to receive(:type).and_return('patrol_boat')
      expect(cell.hit!).to eq('You sank my patrol_boat!')
    end

    it 'on a cell with water in it, return a you missed message' do
      expect(cell.hit!).to eq('You missed!')
    end

  end

  context 'receiving ships' do

    before(:each) {cell.ship_in_cell!(ship_double)}

    it 'should be capable of receiving a ship in it' do
      expect(cell.ship_or_water).to eq(:ship)
    end

  end

  context 'receiving a specific ship' do

    it 'should know which ship object is placed in it' do
      cell.ship_in_cell!(ship_double)
      expect(cell.ship_object).to eq(ship_double)
    end

  end

end