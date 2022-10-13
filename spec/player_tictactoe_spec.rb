require_relative "../tic-tac-toe/player"

# rubocop:disable Metrics
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
# rubocop:enable Metrics
