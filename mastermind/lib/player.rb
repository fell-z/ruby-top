# Player
class Player
  attr_accessor :code

  COLORS = %w[red blue green yellow purple cyan orange white].freeze

  # I know, two methods doing the same thing, I just wanted to name the same
  # code different for the Mastermind class use them correctly
  def guess_code
    get_code
  end

  def new_code
    get_code
  end

  private

  def get_code
    puts "Enter a color available in the list, be sure to enter six colors separated by spaces."

    loop do
      puts "Colors: red, blue, green, yellow, purple, cyan, orange and white."
      print "\n> "
      entry = gets.chomp.downcase.split(" ")

      return entry if entry.all? { |color| COLORS.include? color } && entry.length == 6

      puts "Hmm, it seems that you entered a invalid color or you've not entered six colors."
    end
  end
end
