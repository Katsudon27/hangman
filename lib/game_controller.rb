require_relative "game_board"
require_relative "player"

class GameController
  attr_reader :answer
  def initialize
    @answer = File.readlines("dictionary.txt").select {|word| word.length >= 5 && word.length <= 12}.sample
    @game_board = GameBoard.new(@answer)
    @player = Player.new
  end

  def check_win?
    @game_board.guess == @answer.chars
  end

  def print_instructions
    puts "Welcome to Hangman!"
    puts "Instructions: "
    puts "1. Correctly guess the secret word within 7 guesses."
    puts "2. You can either guess a letter at a time or the entire word if you're confident."
    puts "3. Each incorrect guess will result in a part of the hangman being drawn."
    puts "4. You lose when the hangman is fully drawn."
    puts "START GAME"
  end
end
