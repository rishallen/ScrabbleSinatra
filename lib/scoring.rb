module Scrabble

  class Scoring

  SEVEN_LETTER_BONUS = 50
  #PLAYED_WORDS = []
  #WORD_SCORE_COLLECTION =[]

    LETTERS = {
    %w(A E I O U L N R S T) => 1,
    %w(D G) => 2,
    %w(B C M P) => 3,
    %w(F H V W Y) => 4,
    %w(K) => 5,
    %w(J X) => 8,
    %w(Q Z) => 10
  }

    def self.letter_value(letter)
      LETTERS.each do |key, value|
        if key.include? letter
          return value
        end
      end
      return -100000 # this will allow me to know if there is a number that isn't in the LETTERS hash
    end

    def self.score(word)
      word = word.upcase 
      word_score = 0
      bonus = SEVEN_LETTER_BONUS
      word_score += bonus if word.length == 7
      word_array = word.split("")
      word_array.each do |letter|
        temp_letter_val = letter_value(letter)
        word_score += temp_letter_val
      end
      return word_score
    end

  #return highest score from array_of_tiles
  #in case of tie :
  #      -better to use fewer tiles
  #      -if top scores is between multiple words and one with 7, one using 7 win_words
  #      - multiple words with same score and same length, pick first
    def self.highest_score_from(word_array)
      by_scores = word_array.group_by { |word| self.score(word) }
        win_words = by_scores.max[1]
      if win_words.length == 1
        return win_words[0]
      elsif win_words.any? { |word| word.length == 7 }
          seven_letter_words = win_words.select { |word| word.length == 7}
          return seven_letter_words.first
      else
        min_word = win_words.min_by { |word| word.length }
        return min_word
      end
    end

    def self.many_words(words)
      words_hash = {}
      word_split = words.split(" ")
      word_split.each do |word|
        words_hash[word] = self.score(word) # this is where the key value pair happens
        end
      return words_hash
    end
  end
end
