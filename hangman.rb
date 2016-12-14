require "json"

class Game
    # Chose random Word - done
    # Ask Player for Guess
    # Check player Guess
    # Display guessed Letters
    # Display word with correctly guessed Letters
    # See if there are any saved GameState
    # Load game if player wants to continue game
    # Update GameState
    # Save GameState
    attr_accessor :word, :player, currentGame

    def initialize()

    end
    
    def getWord
        wordToGuess = ""
        randInt = Random.new

        words = File.readlines "5desk.txt"
        got_word = false
        until got_word
            wordToGuess = words[Random.rand(words.length).to_i]
            got_word = true unless (wordToGuess.length < 5 || wordToGuess.length > 11)
        end
        return wordToGuess
    end

    def playGame

    end

    def saveGame

    end

    def loadGame

    end
end

class GameState
    # Word
    # Letters chosen by Player
    # Player object
    # Guesses made
    # Guesses left
end

class Player
    # Get name
    # Get guess
    # Save guess to array
    attr_accessor :name
    def initialize(name)
        @name = name
    end

    def get_letter(letter)
        puts "Enter a letter: "
        letter = gets.chomp
        @gussed_letters << letter
        return letter
    end

    def player_guesses
        return @gussed_letters
    end
end

new_game = Game.new 
puts new_game.getWord