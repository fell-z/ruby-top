require_relative "lib/hangman"

begin
  Hangman.new
rescue StandardError
  puts "The main file must be executed from the root directory!"
end
