# Tic Tac Toe board
class Board
  attr_accessor :squares
  attr_reader :playing

  def initialize(player_one, player_two)
    init_board

    @players = [player_one, player_two]

    @players.each { |player| player.board = self }

    @playing = true
  end

  def display
    puts <<~BOARD
      -----|-----|-----
        #{@squares[0]}  |  #{@squares[1]}  |  #{@squares[2]}
      -----|-----|-----  #{@players[0].name}: #{@players[0].points}
        #{@squares[3]}  |  #{@squares[4]}  |  #{@squares[5]}
      -----|-----|-----  #{@players[1].name}: #{@players[1].points}
        #{@squares[6]}  |  #{@squares[7]}  |  #{@squares[8]}
      -----|-----|-----
    BOARD
  end

  def init_board
    @squares = [
      1, 2, 3,
      4, 5, 6,
      7, 8, 9
    ]
  end

  def keep_playing?
    print "Do you want to keep playing? [Y/n]: "
    @playing = gets.chomp.downcase == "y"
  end
end
