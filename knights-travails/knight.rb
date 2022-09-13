# Chess's knight
class Knight
  # Object representing a path from a position to another.
  class Path
    # Object representing a single square on a chess board,
    # contains a position and a list of possible moves.
    class Square
      attr_reader :pos
      attr_accessor :possible_moves

      def initialize(pos, possible_moves = nil)
        @pos = pos
        @possible_moves = possible_moves || get_possible_moves(@pos)
      end

      private

      DIRECTIONS = {
        north: -2,
        south: 2,
        west: -2,
        east: 2
      }.freeze

      # rubocop:disable Metrics
      def get_possible_moves(start_pos)
        valid_moves = []

        # index 0 = rows
        # index 1 = columns
        DIRECTIONS.each do |direction, distance|
          if %I[north south].include?(direction)
            valid_moves += [
              [start_pos[0] + distance, start_pos[1] - 1],
              [start_pos[0] + distance, start_pos[1] + 1]
            ]
          elsif %I[east west].include?(direction)
            valid_moves += [
              [start_pos[0] - 1, start_pos[1] + distance],
              [start_pos[0] + 1, start_pos[1] + distance]
            ]
          end
        end

        valid_moves.select { |move| move.all? { |pos| pos.between?(0, 7) } }
      end
      # rubocop:enable Metrics
    end

    attr_reader :start_pos, :dest_pos, :shortest_path

    def initialize(start_pos, dest_pos)
      @start_pos = Square.new(start_pos)
      @dest_pos = Square.new(dest_pos)
      @shortest_path = []

      @start_pos.possible_moves.map! do |move|
        square = Square.new(move)
        build_path(square, [start_pos, move])
        square
      end
    end

    def build_path(start_pos, blacklist = [])
      start_pos.possible_moves.map! do |move|
        square = Square.new(move)
        square.possible_moves -= blacklist
        if square.possible_moves.include?(@dest_pos.pos)
          square.possible_moves.map! { |move| Square.new(move, []) }
        else
          build_path(square, blacklist << move) unless square.possible_moves.include?(@dest_pos.pos)
        end
        square
      end
    end

    # rubocop:disable Metrics
    def find_shortest_path(start_pos = @start_pos, current_path = [@start_pos.pos], blacklist = [@start_pos.pos])
      start_pos.possible_moves.each do |square|
        square.possible_moves.reject! { |move| blacklist.include?(move.pos) }
        if start_pos.possible_moves.any? { |move| move.pos == @dest_pos.pos }
          if (current_path.length - 1 < @shortest_path.length - 1) || @shortest_path.empty?
            next @shortest_path = current_path
          end
        end

        # #dup is used to prevent overwriting the 'current_path' of previous method calls
        find_shortest_path(square, current_path + [square.pos], blacklist + square.pos)
      end
      @shortest_path + [@dest_pos.pos]
    end
    # rubocop:enable Metrics
  end

  def knight_moves(start_pos, dest_pos)
    shortest_path = Path.new(start_pos, dest_pos).find_shortest_path
    number_of_moves = shortest_path.length - 1

    puts "You made it in #{number_of_moves} #{number_of_moves == 1 ? 'move' : 'moves'}! Here's your path:"
    shortest_path.each { |move| p move }
  end
end
