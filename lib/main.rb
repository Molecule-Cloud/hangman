require_relative '../player'
require '../word'
require_relative 'game'
require 'yaml' # Add for serialization

puts 'Would you like to load one of your saved games? Enter yes or no'
load_games = gets.chomp.downcase

if load_games == 'yes'
  if File.exist?('saved_game.yml') # Check if the saved file exists
    game = YAML.safe_load(File.read('saved_game.yml'), permitted_classes: [Game, Player, Word])
    puts 'Game loaded!'
  else
    puts 'No saved game found. Starting a new game.'
    player = Player.new('Player1')
    game = Game.new(player)
  end
else
  player = Player.new('Player1')
  game = Game.new(player)
end

def play_again?
  puts 'would you like to play again?'
  answer = gets.chomp.downcase
  answer == 'yes' ? start_game : puts('Thanks for playing')
end

# Start the game
game.start_game
