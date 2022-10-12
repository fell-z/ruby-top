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
end

describe Player do
  describe "#make_a_play" do
    subject(:player) { described_class.new(1) }

    before do
      allow(player).to receive(:sleep)
      allow(player).to receive(:print)
      allow(player).to receive(:set_name)
      @error_message = "Oops! Invalid input or square already taken.\n\n"
    end

    context "when all squares on the board are available" do
      let(:possible_squares) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

      it "returns 4 and the error message doesn't print" do
        allow(player).to receive(:gets).and_return('4')
        expect(player).to_not receive(:puts).with(@error_message)
        player.make_a_play(possible_squares)
      end
    end
  end
end
# rubocop: enable Metrics
