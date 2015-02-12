puts "Hangman initialized!"

class Hangman
	require "csv"

	def initialize(secret_word)
		@secret_word = secret_word.downcase
		@display = ""
		@secret_word.length.times { @display << "_" }
		@guessed_letters = []
		@guesses = 6
		start
	end

	def start
		until @guesses == 0
			puts ""
			puts @display
			break unless @display.include?("_")
			puts "You have #{@guesses} guesses left."
			input = gets.chomp
			until allowed_guess(input)
				puts "Please try again. Make sure you are only entering one letter that you have not already entered."
				input = gets.chomp
			end
			guess(input)
		end
		puts ""
		puts @guesses == 0 ? "You lost. The word was #{@secret_word}" : "You won!"
		puts ""
	end

	def guess(letter)
		@guessed_letters << letter
		@secret_word.split(//).each_with_index { |secret_letter, index| @display[index] = secret_letter if letter == secret_letter }
		@guesses -= 1 unless @secret_word.include?(letter)
	end

	def allowed_guess(guess)
		guess.downcase!
		return false if guess.length > 1 || guess.match(/[0-9]/) || @guessed_letters.include?(guess)
		true
	end
end

dictionary = File.readlines("5desk.txt")
dictionary.map! { |word| word.chomp("\r\n") }

good_words = dictionary.select do |word|
	word.length >= 5 && word.length <= 12
end

secrect_word = good_words.sample
game = Hangman.new(secrect_word)
