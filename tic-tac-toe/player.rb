# Tic Tac Toe player
class Player
  attr_reader :name, :points
  attr_writer :board
  
  @@players = []

  VALID_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # vertical
    [0, 4, 8], [2, 4, 6] # diagonal
  ].freeze

  def initialize
    @@players << self

    @points = 0
    @plays = []

    set_name
  end

  def take_a_move
    selected_square = ""
    print "\n#{@name}, make your move: "
    loop do
      selected_square = gets.chomp.to_i
      break if @board.squares.include? selected_square

      puts "That square has already been taken or you entered a invalid number."
      print "\nMake your move: "
    end
    @plays << @board.squares.index(selected_square)
    @board.squares[@board.squares.index(selected_square)] = @initial_letter

    did_i_win? if @plays.length >= 3
  end

  protected

  def plays=(plays)
    @plays = plays
  end

  private

  def did_i_win?
    return unless VALID_COMBINATIONS.one? do |combination|
      combination.all? do |comb_index|
        @plays.include? comb_index
      end
    end

    @points += 1
    puts "\nCongrats #{@name}! Points: #{@points}."
    @@players.each { |player| player.plays = [] }
    @board.init_board
    @board.keep_playing?
  end

  def set_name
    player_number = @@players.length == 1 ? 1 : 2
    print "Player #{player_number}, please enter your name: "
    loop do
      @name = gets.chomp

      break unless @name.empty? || ("0".."9").include?(@name[0])

      puts "Please, don't start your name with a number or leave your name empty."
      print "Player #{player_number}, please enter your name: "
    end
    @initial_letter = @name[0].upcase
  end
end
