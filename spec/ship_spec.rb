require_relative '../app/ship.rb'

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
      expect(ship.hits).to eq(0)
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
      expect(ship.hits).to eq(1)
    end

    it 'sunk when hit as many times as the size' do
      ship.size.times { ship.hit! }
      expect(ship).to be_sunk
    end

    it 'floating when not hit as many times as the size' do
      (ship.size - 1).times { ship.hit! }
      expect(ship.floating?).to be(true)
    end

  end

  context 'message when hit' do

    it 'You hit my when not sunk' do
      expect(ship.hit!).to eq("You hit my Battleship!")
    end

    it 'You sank my when sunk' do
      (ship.size - 1).times { ship.hit! }
      expect(ship.hit!).to eq("You sank my Battleship!")
    end

  end

end
