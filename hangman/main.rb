require_relative "lib/hangman"

begin
  Hangman.new
rescue SystemCallError
  puts "The main file must be executed from the root directory!"
end
