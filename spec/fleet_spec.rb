require_relative '../app/fleet.rb'

describe Fleet do

  let(:fleet) {Fleet.new}

  context 'a fleet when initialised should' do

    it 'have 5 ships' do
      expect(fleet.ship_array.length).to eq 5
    end

  end

end
