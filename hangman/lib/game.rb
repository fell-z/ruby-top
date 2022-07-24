# Hangman game
class Hangman
  def initialize
    dictionary = File.readlines("lib/dictionary.txt").map(&:chomp).select { |word| word.length.between?(5, 12) }
    @word = dictionary.sample
    @correct_letters = Array.new(@word.length) { "_" }
    @wrong_guesses = []
    @guesses_left = 10

    welcome_message
  end

  private

  def game
    loop do
      break unless play?
    end
  end

  def ask
    answer = ""
    loop do
      puts "\nPlease enter your guess."
      print ">> "
      answer = gets.chomp

      break unless answer.empty?

      puts "Please do not leave your guess empty."
    end
    answer
  end

  def render
    system("clear")

    letter_places = @correct_letters.join
    wrong_guesses = @wrong_guesses.join(" - ")

    puts <<~GAME_STATE
      Letters guessed wrong:
        #{wrong_guesses}
      Guesses left: #{@guesses_left}

      #{letter_places}
    GAME_STATE
  end

  def find_saves() end

  def load_save?() end

  def welcome_message
    puts <<~WELCOME
      Hello! This is a game of hangman written in the Ruby lang.
      The game is basically the original game, with no funny modifications made.

      A word will be selected randomly and you will have 10 attempts to guess the word,
      but you can also try to guess the word directly.

      Obs: You can save the game to later load and resume your session.
    WELCOME
  end

  def play?
    choice = "n"
    loop do
      print "Do you wanna play? [y/N] "
      choice = gets.chomp.downcase

      break if %w[y n].include?(choice)

      puts "Please enter a valid input."
    end
    choice == "y"
  end
end
