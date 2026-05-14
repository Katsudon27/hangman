require_relative "game_board"
require_relative "player"

class GameController
  attr_reader :answer
  def initialize
    @answer = File.readlines("dictionary.txt").select {|word| word.length >= 5 && word.length <= 12}.sample.chomp
    @game_board = GameBoard.new(Array.new(@answer.length, "_"), [], [])
    @player = Player.new
  end

  def check_win?
    @game_board.guess == @answer.chars
  end

  def evaluate_guess(guess)
    if @answer.include?(guess) && guess.length == 1
      @answer.chars.each_with_index do |letter, index|
        if letter == guess
          @game_board.add_letter_guess(index, letter)
        end
      end
    elsif guess == "'s'"
      save_game
    else
      unless guess == @answer
        @game_board.add_incorrect_guess(guess)
        return
      end
      @game_board.add_correct_guess(guess)
    end
  end

  def print_instructions
    puts "Welcome to Hangman!"
    puts "---------------------------------------"
    puts "Instructions: "
    puts "1. Correctly guess the secret word within 7 guesses."
    puts "2. You can either guess a letter at a time or the entire word if you're confident."
    puts "3. Each incorrect guess will result in a part of the hangman being drawn."
    puts "4. You lose when the hangman is fully drawn."
    puts "5. You can opt to save your current game by typing in 's' as your guess."
    puts "---------------------------------------"
  end

  def start_or_load_game
    puts "[1] Start a new game"
    puts "[2] Load a previous save"

    loop do
      puts "Please choose 1 or 2 from the options provided: "
      input = gets.chomp

      return input if input == "1" or input == "2"

      puts "Invalid input: Please try again"
    end
  end

  def start_game
    print_instructions
    player_selection = start_or_load_game

    if player_selection == "2"
      load_game  
    end

    loop do
      @game_board.print_board
      guess = @player.make_guess
      evaluate_guess(guess)

      if check_win?
        @game_board.print_board
        puts "\nCongratulations! You have won the game!"
        break
      elsif @game_board.incorrect_guesses.length == 7
        @game_board.print_board
        puts "\nOops, you have run out out of guesses."
        puts "The secret word was '#{@answer}'."
        break
      end
    end
  end

  def to_yaml
    YAML.dump ({
      :answer => @answer,
      :game_board => @game_board.to_yaml
    })
  end

  def from_yaml(string)
    data = YAML.load(string)
    @answer = data[:answer]
    @game_board = GameBoard.from_yaml(data[:game_board])
  end
  
  def save_game
    File.open("player_save.yaml", "w") do |f|
      f.write(to_yaml)
    end
    puts "Game successfully saved! You can quit the game now."
  end

  def load_game
    if File.exist?("player_save.yaml")
      from_yaml(File.read("player_save.yaml"))
      puts "Your previous save from #{File.mtime("player_save.yaml")} has been successfully loaded. Good luck!"
    else
      puts "No previous save found. Starting a new game for you!"
    end
  end
end
