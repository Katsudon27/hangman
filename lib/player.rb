# A base class for the human player
class Player
  def make_guess
    loop do
      puts "\nGuess a letter in the secret word: "
      input = gets.chomp.downcase

      return input if ((input.chars - ("a".."z").to_a).empty? && input.length >= 1) || input == "'s'"

      puts "Invalid input: Please try again"
    end
  end
end
