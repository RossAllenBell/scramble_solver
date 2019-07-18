require 'json'

begin
  letters = ARGV[0].to_s.downcase
  puts "Expected letter set of 5 to 7 characters as input." and return if letters.size < 5 || letters.size > 7
  error = ARGV[1]
  puts "Only expected one argument." and return if !error.nil?

  letters_array = letters.chars

  anagrams_to_words = JSON.parse(open('./anagrams_to_words.json').read)

  anagrams = anagrams_to_words.keys.select do |key|
    key_array = key.chars
    letters_array.each do |letter|
      index = key_array.rindex(letter)
      key_array.delete_at(index) if !index.nil?
    end
    if key_array.size == 0
      true
    else
      false
    end
  end

  words = anagrams.map do |anagram|
    anagrams_to_words[anagram]
  end.flatten

  words.sort_by do |word|
    [-word.size, word]
  end.each do |word|
    puts word
  end
end;nil
