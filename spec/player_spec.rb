require 'player'

describe Player do

  let(:player){Player.new('Josh', board_class, fleet_class)}
  let(:board_class){double :board_class, new: board}
  let(:fleet_class){double :fleet_class, new: fleet}
  let(:board){double :board}
  let(:fleet){double :fleet}
  let(:cell_double){double :cell_double}

  context 'a player can' do

    it 'have a board' do
      expect(player.board).to eq(board)
    end

    it 'have a fleet' do
      expect(player.fleet).to eq(fleet)
    end

    it 'have a name' do
      expect(player.name).to eq("Josh")
    end

  end

  context 'taking shots' do

    it 'receive a shot' do
      allow(board).to receive(:cell_object).with(:A1).and_return(cell_double)
      allow(fleet).to receive(:sunk?).and_return false
      expect(board.cell_object(:A1)).to receive(:hit!)
      player.receive_shot(:A1)
    end

    it 'should return a losing message if all players ships were sunk' do
      allow(fleet).to receive(:sunk?).and_return true
      expect(player.is_fleet_sunk?).to eq('Josh has lost!')
    end

  end
end