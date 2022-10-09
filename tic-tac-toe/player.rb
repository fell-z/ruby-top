# TicTacToe player
class Player
  attr_reader :name, :plays

  def initialize(player_number)
    @name = set_name(player_number)
    @plays = []
  end

  def make_a_play(possible_squares)
    loop do
      print "Your turn, #{@name}. Select a empty square.\n>> "
      play = gets.chomp.to_i

      if (1..9).include?(play) && possible_squares.include?(play)
        @plays << play
        break play
      end

      puts "Oops! Invalid input or square already taken.\n\n"
    end
  end

  def reset_plays
    @plays = []
  end

  private

  # rubocop: disable Naming
  def set_name(player_number)
    loop do
      print "Player #{player_number}, insert your name starting with a letter.\n>> "
      name = gets.chomp
      break name if ("a".."z").include?(name[0].downcase)

      puts "\nOops! Name not starting with a letter."
    end
  end
  # rubocop: enable Naming
end
