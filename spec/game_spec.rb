require_relative '../app/game.rb'

describe Game do

  let(:game) {Game.new}
  let(:player_dble_1) {double :player_dble_1, name: "Josh"}
  let(:player_dble_2) {double :player_dble_2, name: "Andy"}

  context 'when initialized' do

    it 'should have an empty fleets array' do
      expect(game.fleets).to be_empty
    end

    it 'should have an empty players array' do
      expect(game.players).to be_empty
    end

  end

  context 'adding a player' do

    before(:each) do
      game.add_player("Josh")
    end

    it 'should add a player to the players array' do
      expect(game.players.length).to eq(1)
    end

    it 'should add a fleet to the fleet array' do
      expect(game.fleets.length).to eq(1)
    end

  end

  context 'knowing whether 2 players have registered' do

    it 'should return false when one registered' do
      allow(game).to receive(:players).and_return([player_dble_1])
      expect(game.has_two_players?).to be(false)
    end


    it 'should return true when two registered' do
      allow(game).to receive(:players).and_return([player_dble_1, player_dble_2])
      expect(game.has_two_players?).to be(true)
    end

  end

  context 'knowing about the players' do

    before(:each) do
      allow(game).to receive(:players).and_return([player_dble_1, player_dble_2])
    end

    it 'should give the first turn to the first player created' do
      expect(game.current_player).to eq("Josh")
    end

    it 'should be able to switch turns to the other player' do
      game.switch_turns
      expect(game.current_player).to eq("Andy")
    end

    it 'should return the name of the opponent' do
      allow(game).to receive(:current_player).and_return("Josh")
      expect(game.opponent_name).to eq("Andy")
    end

  end

  context 'managing the fleets for ship placement' do

    before(:each) do
      allow(game).to receive(:index_current_player).and_return(0)
    end

    context 'knowing whether a current players fleet is empty' do

      it 'should return true when it is empty' do
        allow(game).to receive(:fleets).and_return([[],[]])
        expect(game.fleet_empty?).to be(true)
      end

      it 'should return false when it is not empty' do
        allow(game).to receive(:fleets).and_return([[1],[]])
        expect(game.fleet_empty?).to be(false)
      end

    end

    context 'handling the ship to be placed' do

      it 'should return the first ship in the players fleet to be placed' do
        allow(game).to receive(:fleets).and_return([[1],[]])
        expect(game.ship_to_place).to eq(1)
      end

      it 'should remove the placed ship from the fleet' do
        allow(game).to receive(:fleets).and_return([[1],[]])
        expect(game.remove_placed_ship_from_fleet).to eq(1)
      end

    end

  end

end
