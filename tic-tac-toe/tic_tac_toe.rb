# TicTacToe game
class TicTacToe
  VALID_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # horizonal
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical
    [1, 5, 9], [3, 5, 7] # diagonal
  ].freeze

  def initialize(player_one, player_two)
    @board = [
      1, 2, 3,
      4, 5, 6,
      7, 8, 9
    ]
    @player_one = player_one
    @player_two = player_two
  end

  def render
    system("clear")
    puts <<~BOARD
      -----|-----|-----
        #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}
      -----|-----|-----  #{@player_one.name}: #{@player_one.points}
        #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}
      -----|-----|-----  #{@player_two.name}: #{@player_two.points}
        #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}
      -----|-----|-----
    BOARD
  end
end
