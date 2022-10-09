# TicTacToe player
class Player
  attr_reader :name, :points, :plays

  def initialize
    @name = set_name
    @points = 0
    @plays = []
  end

  private

  def set_name
    loop do
      print "Please, insert your name starting with a letter.\n>> "
      name = gets.chomp
      break name if ("a".."z").to_a.include?(name[0].downcase)

      puts "\nInput error: name not starting with letter."
    end
  end
end
