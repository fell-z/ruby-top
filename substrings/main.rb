def substrings(phrase, dictionary)
  phrase_words = phrase.split(" ").map(&:downcase)

  phrase_words.reduce(Hash.new(0)) do |words_count, phrase_word|
    dictionary.each do |dict_word|
      words_count[dict_word] += 1 if phrase_word.include? dict_word
    end
    words_count
  end
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

p substrings("\nHowdy partner, sit down! How's it going?", dictionary)
