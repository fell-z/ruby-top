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

  def ask_letter
    loop do
      puts "\nEnter your guess."
      print ">> "
      answer = gets.chomp.downcase

      break answer unless answer.empty? || answer.length != 1

      puts "Please enter a one-letter guess."
    end
  end

  # rubocop:disable Metrics/MethodLength
  def ask_word
    loop do
      puts "\nEnter your guess."
      print ">> "
      answer = gets.chomp.downcase

      if answer.empty? || answer.length == 1
        puts "Please enter a word."
        next
      end

      print "That's your final answer? [y/N] "

      next unless choice == "y"

      break answer
    end
  end
  # rubocop:enable Metrics/MethodLength

  def check_guess(guess, correct_letters)
    return correct_letters unless @word.include?(guess)

    correct_letters.map.with_index do |letter_place, index|
      next guess if @word[index] == guess

      letter_place
    end
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
    loop do
      print "Do you wanna play? [y/N] "
      choice = gets.chomp.downcase

      break choice == "y" if %w[y n].include?(choice)

      puts "Please enter a valid input."
    end
  end
end
