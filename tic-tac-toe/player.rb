# TicTacToe player
class Player
  attr_reader :sym, :plays

  def initialize(player_number)
    @sym = player_number == 1 ? "X" : "O"
    @plays = []
  end

  def make_a_play(possible_squares)
    loop do
      print "Your turn, Player #{(@sym == "X" ? 1 : 2)}. Select a empty square.\n>> "
      play = gets.chomp.to_i

      if (1..9).include?(play) && possible_squares.include?(play)
        @plays << play
        break play
      end

      puts "Oops! Invalid input or square already taken.\n\n"
      sleep(1)
    end
  end
end
