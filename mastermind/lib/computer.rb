# Computer AI
class Computer
  attr_accessor :code, :last_guess, :last_guess_feedback

  COLORS = %w[red blue green yellow purple cyan orange white].freeze

  def initialize
    @last_guess = []
    @last_guess_feedback = { wrong_place: Array.new(6) { nil }, right_place: Array.new(6) { nil } }
  end

  def new_code
    code = []
    6.times do |_index|
      code << new_random_color
    end
    code
  end

  # rubocop:disable Metrics
  def guess_code
    unless check_last_guess_existance?
      return new_code
    end

    new_guess = Array.new(6) { nil }
    index_exceptions = []
    color_exceptions = []

    # this prevents the computer from using colors that doesn't exist in the code
    @last_guess.each do |color|
      feedback_occurrences = @last_guess_feedback[:wrong_place].count(color)

      color_exceptions << color if @last_guess.count(color) > feedback_occurrences && feedback_occurrences.zero?
    end
    color_exceptions.uniq!

    @last_guess_feedback[:right_place].each_with_index do |color, index|
      next if color.nil?

      index_exceptions << index
      new_guess[index] = color
    end

    @last_guess_feedback[:wrong_place].each_with_index do |color, index|
      next if color.nil? || color_exceptions.include?(color)

      index_to_use = new_random_index(index_exceptions, index)

      new_guess[index_to_use] = color
      index_exceptions << index_to_use
    end

    while new_guess.any?(nil)
      index_to_use = new_guess.index(nil)

      loop do
        new_guess[index_to_use] = new_random_color

        break unless color_exceptions.include?(new_guess[index_to_use])
      end
    end

    new_guess
  end
  # rubocop:enable all

  private

  def new_random_color
    COLORS[(rand * COLORS.length).floor]
  end

  def new_random_index(index_exceptions, temp_index_exception)
    index = 0
    loop do
      index = (rand * 6).floor

      break unless index_exceptions.include?(index) || temp_index_exception == index
    end
    index
  end

  def check_last_guess_existance?
    @last_guess_feedback[:wrong_place].any? || @last_guess_feedback[:right_place].any?
  end
end
