require "colorize"

# A class that represents the game board for Hangman
class GameBoard
  attr_reader :incorrect_guesses, :guess

  def initialize(answer)
    @guess = Array.new(answer.length, "_")
    @incorrect_guesses = []
    @stick_figure = []
  end

  def print_board
    puts "---------------------------------------"
    display_guess
    print "\n"
    display_incorrect_letters
    puts @stick_figure
  end

  def update_stick_figure
    case @incorrect_guesses.length
    when 0
      return
    when 1
      @stick_figure = [" ________", "|", "|", "|", "|", "|"]
    when 2
      @stick_figure[1] += "\t |"
      @stick_figure[2] += "\t O"
    when 3
      @stick_figure[3] += "\t/"
    when 4
      @stick_figure[3] += "|"
    when 5
      @stick_figure[3] += "\\"
    when 6
      @stick_figure[4] += "\t/"
    when 7
      @stick_figure[4] += " \\"
    end
  end

  def display_guess
    print "Your current guess: "
    puts @guess.join(" ")
  end

  def display_incorrect_letters
    print "Incorrect letters: "
    puts @incorrect_guesses.join(" ")
  end

  def add_letter_guess(index, letter)
    @guess[index] = letter
  end

  def add_incorrect_guess(letter)
    @incorrect_guesses << letter
    update_stick_figure
  end

  def add_correct_guess(guess)
    @guess = guess.chars
  end
end
