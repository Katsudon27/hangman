# A base class for the human player
class Player
  def make_guess
    loop do
      puts "Guess a letter in the secret word: "
      input = gets.chomp.downcase

      return input if ("a".."z").to_a.include?(input) && input.length == 1

      puts "Invalid input: Please try again"
    end
  end
end
