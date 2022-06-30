require_relative "lib/player"
require_relative "lib/computer"
require_relative "lib/mastermind"

player = Player.new
computer = Computer.new

Mastermind.new(player, computer).play
