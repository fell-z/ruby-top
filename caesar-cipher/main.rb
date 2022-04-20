def caesar_cipher(text, shift_factor)
  numbers_of_letters = 26
  lowercase_alphabet = ("a".."z").to_a
  uppercase_alphabet = ("A".."Z").to_a

  ciphered_text = text.split("").map do |char|
    next char unless lowercase_alphabet.include?(char) || uppercase_alphabet.include?(char)

    ciphered_letter_index = (uppercase_alphabet.index(char) || lowercase_alphabet.index(char)) + shift_factor
    # wrapping 'Z' to 'A'
    ciphered_letter_index -= numbers_of_letters if ciphered_letter_index >= numbers_of_letters
    # wrapping 'A' to 'Z' (backwards 0 -> 26)
    ciphered_letter_index = numbers_of_letters + ciphered_letter_index if ciphered_letter_index.negative?

    case char
    when char.downcase
      lowercase_alphabet[ciphered_letter_index]
    when char.upcase
      uppercase_alphabet[ciphered_letter_index]
    end
  end
  ciphered_text.join
end

print "Please, input something to cipher. > "
input_text = gets.chomp
puts "\n"

print "Now, the shift factor, negative numbers for left shift, otherwise positive for right shift. > "
input_shift_factor = gets.chomp.to_i
puts "\n"

raise TypeError, "No text or invalid shift factor!" if input_text.empty? || input_shift_factor.eql?(0)

result = caesar_cipher(input_text, input_shift_factor)
puts "Result: #{result}"
