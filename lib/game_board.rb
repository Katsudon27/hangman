require "colorize"

# A class that represents the game board for Hangman
class GameBoard
  def initialize(answer)
    @guess = Array.new(answer.length, "_")
    @incorrect_guesses = []
    @stick_figure = [" _______", "|", "|", "|", "|", "|"]
  end

  def print_board
    puts "---------------------------------------"
    display_guess
    print "\n"
    display_incorrect_letters
    display_stick_figure
  end

  def display_stick_figure
    case @incorrect_guesses.length
    when 0
      return
    when 1
      puts @stick_figure
      return
    when 2
      @stick_figure[1] += "\t|"
      @stick_figure[2] += "\tO"
    when 3
      @stick_figure[3] += "\t/"
    when 4
      @stick_figure[3] += "|"
    when 5
      @stick_figure[3] += "\\"
    when 6
      @stick_figure[4] += "\t/"
    when 7
      @stick_figure[4] += "\\"
    end
    puts @stick_figure
  end

  def display_guess
    print "Your current guess: "
    puts @guess.join(" ")
  end

  def display_incorrect_letters
    print "Incorrect letters: "
    puts @incorrect_guesses.join(" ")
  end
end
