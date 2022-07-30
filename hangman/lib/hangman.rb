require "json"
require "time"

# Hangman game
class Hangman
  SAVE_FOLDER = "saves".freeze

  def initialize
    dictionary = File.readlines("lib/dictionary.txt").map(&:chomp).select { |word| word.length.between?(5, 12) }
    @word = dictionary.sample
    @correct_letters = Array.new(@word.length) { "_" }
    @wrong_word_guesses = []
    @wrong_letter_guesses = []
    @guesses_left = 10

    welcome_message
    game
  end

  private

  # rubocop:disable Metrics/MethodLength
  def game
    return unless play?

    loop do
      render

      if @guesses_left.zero?
        puts "You lost, your 10 attempts are over. Better luck next time!"
        puts "The word was '#{@word}'."
        break
      end

      action_choice = choose_action

      case action_choice
      when "1"
        @correct_letters = check_guess(ask_letter)
      when "2"
        @correct_letters = check_guess(ask_word)
      when "3"
        save_game
        break
      else
        next
      end

      @guesses_left -= 1

      next unless @correct_letters.join == @word

      puts "Congratulations! you've guessed the word!"
      break
    end
  end
  # rubocop:enable Metrics/MethodLength

  def choose_action
    puts <<~CHOICES
      Select your action:
        (1) Guess the letter.
        (2) Guess the word.
        (3) Save the game.
    CHOICES
    print ">> "
    gets.chomp
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

      if answer.empty? || answer.length != @word.length
        puts "Please enter a valid word with the right length."
        next
      end

      print "That's your final answer? [y/N] "

      next unless gets.chomp.downcase == "y"

      break answer
    end
  end
  # rubocop:enable Metrics/MethodLength

  def check_guess(guess)
    unless @word.include?(guess)
      @wrong_letter_guesses << guess if guess.length == 1

      @wrong_word_guesses << guess if guess.length > 1

      return @correct_letters
    end

    return @word.split("") if guess.length > 1

    @correct_letters.map.with_index do |letter_place, index|
      next guess if @word[index] == guess

      letter_place
    end
  end

  def render
    system("clear")

    letter_places = @correct_letters.join
    wrong_letter_guesses = @wrong_letter_guesses.join(" - ")
    wrong_word_guesses = @wrong_word_guesses.join(" - ")

    puts <<~GAME_STATE
      Hangman

      Letters guessed wrong:
        #{wrong_letter_guesses}
      Words guessed wrong:
        #{wrong_word_guesses}
      Guesses left: #{@guesses_left}

      #{letter_places}

    GAME_STATE
  end

  def save_game
    Dir.mkdir(SAVE_FOLDER) unless Dir.exist?(SAVE_FOLDER)

    content = {
      word: @word,
      correct_letters: @correct_letters,
      wrong_letter_guesses: @wrong_letter_guesses,
      wrong_word_guesses: @wrong_word_guesses,
      guesses_left: @guesses_left
    }
    File.write("#{SAVE_FOLDER}/#{Time.new.strftime('%Y-%m-%d %H:%M:%S')}.json", JSON.dump(content))
  end

  def load_save?
    return if Dir.children(SAVE_FOLDER).empty?

    puts "There are saved games available."

    loop do
      print "Do you want to load one of them? [y/N] "
      choice = gets.chomp.downcase

      break choice == "y" if %w[y n].include?(choice)

      puts "Please enter a valid input."
    end
  end

  def select_save
    saves = Dir.children(SAVE_FOLDER)

    puts "There are #{saves.length} save files."
    saves.each_with_index do |save, index|
      puts "(#{index + 1}) #{save.sub('.json', '')}"
    end

    loop do
      print "Select a game to load.\n>> "
      choice = gets.chomp.to_i

      break saves[(choice.to_i - 1)] if ("1"..(saves.length.to_s)).to_a.include?(choice)

      puts "Please enter a valid input."
    end
  end

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
