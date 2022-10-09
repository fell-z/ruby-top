# TicTacToe player
class Player
  attr_reader :name, :points, :plays

  def initialize
    @name = set_name
    @points = 0
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
      sleep(1.5)
    end
  end

  def update_score
    @points += 1
  end

  def reset_plays
    @plays = []
  end

  private

  def set_name
    loop do
      print "Insert your name starting with a letter.\n>> "
      name = gets.chomp
      break name if ("a".."z").include?(name[0].downcase)

      puts "\nOops! Name not starting with a letter."
    end
  end
end
