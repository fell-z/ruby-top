# TicTacToe game
class TicTacToe
  # This method was taken from the previous implementation, in order to reduce work.
  # TODO: must change the values in the interpolation to the correct values
  def render
    system("clear")
    puts <<~BOARD
      -----|-----|-----
        #{1}  |  #{2}  |  #{3}
      -----|-----|-----  #{'Player 1 name'}: #{'Player 1 points'}
        #{4}  |  #{5}  |  #{6}
      -----|-----|-----  #{'Player 2 name'}: #{'Player 2 points'}
        #{7}  |  #{8}  |  #{9}
      -----|-----|-----
    BOARD
  end
end
