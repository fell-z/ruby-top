# Mastermind game
class Mastermind
  def initialize(player, computer)
    puts <<~WELCOME
      Hi! This is a mastermind game with some rules changed, like when you get one
      color correct but in the wrong place, it tells you what color you get it right,
      like in the wordle game! Also, instead of a code of 4 colors, it's gonna be 6,
      there's 8 colors to choose from.

      You want to be the codebreaker or the codemaker?
    WELCOME

    loop do
      print "> "
      player_role = gets.chomp.downcase

      case player_role
      when "codebreaker"
        @codebreaker = player
        @codemaker = computer
        break
      when "codemaker"
        @codemaker = player
        @codebreaker = computer
        break
      else
        puts "It seems you entered a invalid answer, please select between codebreaker or codemaker."
      end
    end
  end

  def play
    who_won = nil
    @codemaker.code = @codemaker.new_code
    p @codemaker.code
    8.times do |time|
      puts "#{time + 1}st try"
      if compare_the?(@codebreaker.guess_code, @codemaker.code)
        who_won = @codebreaker
        break
      end
      system("clear")
    end

    who_won = @codemaker if who_won.nil?
    if who_won.instance_of?(Player)
      puts "Player, congrats! You defeated the computer!"
    else
      puts "Player, it wasn't this time, but good luck with the next one."
    end
  end

  private

  def compare_the?(guess, code)
    return true if guess == code

    feedback = create_feedback_on(guess, code)

    if @codebreaker.instance_of?(Computer)
      @codebreaker.last_guess.replace(guess)
      @codebreaker.last_guess_feedback.replace(feedback)
    end

    show_feedback(feedback, guess)

    sleep 1.8

    false
  end

  # rubocop:disable Metrics
  def create_feedback_on(guess, code)
    occurrences = {
      wrong_place: Array.new(6) { nil },
      right_place: Array.new(6) { nil }
    }

    guess.each_with_index do |guess_color, guess_index|
      if code[guess_index] == guess_color
        occurrences[:right_place][guess_index] = guess_color
      elsif code[guess_index] != guess_color && code.include?(guess_color)
        occurrences[:wrong_place][guess_index] = guess_color
      end
    end

    occurrences[:wrong_place].map! do |color|
      code_occurrences = code.count(color)
      right_place_occurrences = occurrences[:right_place].count(color)
      wrong_place_occurrences = occurrences[:wrong_place].count(color)

      next nil if code_occurrences == right_place_occurrences
      # I tried to maintain always the first ones that are in wrong location, but i've failed to do,
      # so I decided to leave things the way they are now
      next nil if (right_place_occurrences + wrong_place_occurrences) > code_occurrences

      color
    end
    occurrences
  end
  # rubocop:enable all

  def show_feedback(feedback, guess)
    feedback_message = Array.new(6) { nil }
    feedback.each do |place, _colors|
      symbol_to_use = (place == :right_place) ? "O" : "X"

      feedback[place].each_with_index do |color, index|
        feedback_message[index] = symbol_to_use unless color.nil?
      end
    end

    feedback_message = feedback_message.reduce("") { |message, symbol| message << symbol.to_s.center(9) }
    guess_message = guess.reduce("") { |message, color| message << color.center(9) }

    puts <<~FEEDBACK

      Guess:   #{guess_message}
      Feedback:#{feedback_message}
      'O': Right color and place
      'X': Right color, but wrong place
    FEEDBACK
  end
end
