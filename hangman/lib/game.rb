# Hangman game
class Hangman
  def initialize
    dictionary = File.readlines("lib/dictionary.txt").map(&:chomp).select { |word| word.length.between?(5, 12) }
    @word = dictionary.sample

    welcome_message
  end

  private

  def game() end

  def ask() end

  def render() end

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
end
