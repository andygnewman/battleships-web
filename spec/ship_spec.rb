require 'ship'

describe Ship do

  let(:ship) { Ship.battleship }

  context 'can be created with a' do
    it 'size' do
      expect(ship.size).to eq(4)
    end

    it 'type' do
      expect(ship.type).to eq(:battleship)
    end

    it 'hits received' do
      expect(ship.hits_received).to eq(0)
    end

  end

  context 'returns error if' do
    
    it 'not recognised ship parameter is passed' do
      expect{Ship.banana}.to raise_error(NoMethodError, "undefined method `banana' for Ship:Class")
    end

  end

  context 'can be' do

    it 'hit by a shot' do
      ship.hit!
      expect(ship.hits_received).to eq(1)
    end

    it 'sunk' do
      ship.size.times { ship.hit! }
      expect(ship).to be_sunk
    end
  end

end