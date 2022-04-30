require_relative "board"
require_relative "player"

p1 = Player.new
p2 = Player.new

board = Board.new p1, p2

loop do
  board.display
  p1.take_a_move

  unless board.playing
    puts "See you next time!"
    break
  end

  board.display
  p2.take_a_move

  unless board.playing
    puts "See you next time!"
    break
  end
end
