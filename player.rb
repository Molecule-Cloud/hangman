class Player
  attr_accessor :name, :guess_letters, :incorrect_guesses

  def initialize(_word)
    @name = name
    @guessed_letters = []
    @incorrect_guesses = []
  end

  def guess_letter
    gets.chomp.downcase
  end

  def record_incorrect_guesses(letter)
    @incorrect_guesses << letter unless @incorrect_guesses.include?(letter)
  end
end
