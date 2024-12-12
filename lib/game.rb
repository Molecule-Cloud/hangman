require 'yaml'

class Game
  attr_accessor :player, :attempts, :word

  def initialize(player)
    @player = player
    @attempts = 10
    @word = Word.new(dictionary)
  end

  def dictionary
    words = File.foreach('../google-10000-words.txt').map(&:strip)
    eligible_words = words.reject { |word| word.length < 5 || word.length > 12 }
    eligible_words.sample
  end

  def start_game
    until game_over?
      puts @word.display_word
      display_incorrect_guesses
      display_attempts
      puts "Continue guessing or type 'save' to save"
      save_game = gets.chomp.downcase
      if save_game == 'save'
        save_game?
        puts 'Game Saved'
      else
        letter = save_game
      end
      letter = @player.guess_letter
      if @word.check_guess(letter)
        puts "Good thinking! You guessed the correct word: #{@word.word.capitalize}"
      else
        @player.record_incorrect_guesses(letter)
        @attempts -= 1
        puts "Activate your super cognitive muscles. Attempts remaining: #{@attempts}"
      end
    end
    play_again?
  end

  def game_over?
    @attempts.zero? || @word.is_word_guessed?
  end

  def end_game
    if @word.is_word_guessed?
      puts 'Congratulations... You are a super smartie!'
    else
      puts "Awwww.... You can try again. The word was #{@word.word}"
    end
  end

  def display_incorrect_guesses
    puts "Incorrect Guesses: #{@player.incorrect_guesses.join(', ')}"
  end

  def display_attempts
    puts "Attempts: #{@attempts}"
  end

  def save_game?
    File.open('saved_game.yml', 'w') { |file| file.write(YAML.dump(self)) }
  end
end
