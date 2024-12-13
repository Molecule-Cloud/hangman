class Word
  attr_reader :word

  def initialize(word)
    @word = word
    @guessed_letters = []
  end

  def display_word
    puts @word.chars.map { |char| @guessed_letters.include?(char) ? char : '-' }.join(' ')
  end

  def check_guess(letter)
    if @word.include?(letter)
      @guessed_letters << letter unless @guessed_letters.include?(letter)
      true
    else
      false
    end
  end

  def is_word_guessed?
    (@word.chars - @guessed_letters).empty?
  end
end
