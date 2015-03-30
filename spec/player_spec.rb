require_relative '../app/player.rb'

describe Player do

  let(:player){Player.new()}
  let(:board){double :board}

  context 'when initialized' do

    it 'should not have a name' do
      expect(player.name).to be(nil)
    end

    it 'should not have a board' do
      expect(player.board).to be(nil)
    end

  end

  context 'a player can' do

    it 'have a board' do
      player.set_board(board)
      expect(player.board).to eq(board)
    end

    it 'have a name' do
      player.set_name("Josh")
      expect(player.name).to eq("Josh")
    end

  end

  context 'know whether the player has a board' do

    it 'should know that it has not got a board' do
      expect(player.has_board?).to be(false)
    end

    it 'should know that it has got a board' do
      player.set_board(board)
      expect(player.has_board?).to be(true)
    end

  end

end
