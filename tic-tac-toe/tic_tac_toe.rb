require_relative "./player"

# TicTacToe game
class TicTacToe
  VALID_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # horizonal
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical
    [1, 5, 9], [3, 5, 7] # diagonal
  ].freeze

  def initialize(player_one = Player.new(1), player_two = Player.new(2))
    @board = [
      1, 2, 3,
      4, 5, 6,
      7, 8, 9
    ]
    @player_one = player_one
    @player_two = player_two
  end

  def start_player_turn(player)
    possible_squares = @board.select { |square| square.is_a?(Numeric) }
    play = player.make_a_play(possible_squares)
    update_board(player, play)
    sleep(1.5)
  end

  def update_board(player, square_pos)
    @board[square_pos - 1] = player.name[0].upcase
  end

  def game_over?(player)
    VALID_COMBINATIONS.one? do |valid_comb|
      valid_comb.intersection(player.plays.sort) == valid_comb
    end
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
