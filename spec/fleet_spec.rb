require 'fleet'

describe Fleet do

  let(:fleet) {Fleet.new}

  context 'a fleet when initialised should' do

    it 'have 9 ships' do
      expect(fleet.ship_array.length).to eq 9
    end

  end

  context 'a fleet should know when it\'s' do

    it 'ships are all sunk' do
      ship1 = double :ship1, sunk?: true
      ship2 = double :ship2, sunk?: true
      allow(fleet).to receive(:ship_array).and_return([ship1, ship2])
      expect(fleet).to be_sunk
    end

    it 'no ships are sunk' do
      ship1 = double :ship1, sunk?: false
      ship2 = double :ship2, sunk?: false
      allow(fleet).to receive(:ship_array).and_return([ship1, ship2])
      expect(fleet).not_to be_sunk
    end

    it 'if some, but not all ships are sunk' do
      ship1 = double :ship1, sunk?: true
      ship2 = double :ship2, sunk?: false
      allow(fleet).to receive(:ship_array).and_return([ship1, ship2])
      expect(fleet).not_to be_sunk
    end

  end
 
end