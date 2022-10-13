require_relative "../tic-tac-toe/player"
require_relative "../tic-tac-toe/tic_tac_toe"

# rubocop: disable Metrics
describe TicTacToe do
  describe "#game_over?" do
    let(:player_one) { double('player') }
    let(:player_two) { double('player') }
    subject(:game) { described_class.new(player_one, player_two) }

    context "when is a horizontal sequence" do
      it "returns true for the sequence '[1, 2, 3]'" do
        allow(player_one).to receive(:plays).and_return([1, 2, 3])
        expect(game.game_over?(player_one)).to be_truthy
      end

      it "returns true for the sequence '[4, 5, 6]'" do
        allow(player_one).to receive(:plays).and_return([4, 5, 6])
        expect(game.game_over?(player_one)).to be_truthy
      end

      it "returns true for the sequence '[7, 8, 9]'" do
        allow(player_one).to receive(:plays).and_return([7, 8, 9])
        expect(game.game_over?(player_one)).to be_truthy
      end
    end

    context "when is a vertical sequence" do
      it "returns true for the sequence '[1, 4, 7]'" do
        allow(player_one).to receive(:plays).and_return([1, 4, 7])
        expect(game.game_over?(player_one)).to be_truthy
      end

      it "returns true for the sequence '[2, 5, 8]'" do
        allow(player_one).to receive(:plays).and_return([2, 5, 8])
        expect(game.game_over?(player_one)).to be_truthy
      end

      it "returns true for the sequence '[3, 6, 9]'" do
        allow(player_one).to receive(:plays).and_return([3, 6, 9])
        expect(game.game_over?(player_one)).to be_truthy
      end
    end

    context "when is a diagonal sequence" do
      it "returns true for the sequence '[1, 5, 9]'" do
        allow(player_one).to receive(:plays).and_return([1, 5, 9])
        expect(game.game_over?(player_one)).to be_truthy
      end

      it "returns true for the sequence '[3, 5, 7]'" do
        allow(player_one).to receive(:plays).and_return([3, 5, 7])
        expect(game.game_over?(player_one)).to be_truthy
      end
    end

    context "when is a invalid sequence" do
      it "returns false for the sequence '[1, 3, 5]'" do
        allow(player_one).to receive(:plays).and_return([1, 3, 5])
        expect(game.game_over?(player_one)).to be_falsey
      end

      it "returns false for the sequence '[3, 4, 7]'" do
        allow(player_one).to receive(:plays).and_return([3, 4, 7])
        expect(game.game_over?(player_one)).to be_falsey
      end

      it "returns false for the sequence '[2, 5, 9]'" do
        allow(player_one).to receive(:plays).and_return([2, 5, 9])
        expect(game.game_over?(player_one)).to be_falsey
      end

      it "returns false for the sequence '[4, 7, 8]'" do
        allow(player_one).to receive(:plays).and_return([4, 7, 8])
        expect(game.game_over?(player_one)).to be_falsey
      end
    end
  end

  describe "#start_player_turn" do
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }
    subject(:game) { described_class.new(player_one, player_two) }

    it "calls the #make_a_play method in the player object" do
      allow(game).to receive(:update_board)
      expect(player_one).to receive(:make_a_play)
      game.start_player_turn(player_one)
    end
  end
end

describe Player do
  describe "#make_a_play" do
    subject(:player) { described_class.new(1) }

    before do
      allow(player).to receive(:sleep)
      allow(player).to receive(:print)
      @error_message = "Oops! Invalid input or square already taken.\n\n"
    end

    context "when all squares on the board are available" do
      let(:possible_squares) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

      it "doesn't print the error message when the input is 4" do
        allow(player).to receive(:gets).and_return('4')
        expect(player).to_not receive(:puts).with(@error_message)
        player.make_a_play(possible_squares)
      end

      it "doesn't print the error message when the input is 9" do
        allow(player).to receive(:gets).and_return('9')
        expect(player).to_not receive(:puts).with(@error_message)
        player.make_a_play(possible_squares)
      end
    end

    context "when a few squares are unavailable" do
      let(:possible_squares) { [1, 2, 4, 6, 7, 8] }

      it "doesn't print the error message when the input is 2" do
        allow(player).to receive(:gets).and_return('2')
        expect(player).to_not receive(:puts).with(@error_message)
        player.make_a_play(possible_squares)
      end

      it "prints the error message once" do
        allow(player).to receive(:gets).and_return('5', '2')
        expect(player).to receive(:puts).with(@error_message).once
        player.make_a_play(possible_squares)
      end

      it "prints the error message twice" do
        allow(player).to receive(:gets).and_return('t', '5', '2')
        expect(player).to receive(:puts).with(@error_message).twice
        player.make_a_play(possible_squares)
      end
    end
  end
end
# rubocop: enable Metrics
