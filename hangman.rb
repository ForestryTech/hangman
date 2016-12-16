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
    attr_accessor :word, :player, :current_game, :saved_games

    def initialize()
        puts "Welcome to Hangman!"
        @player = Player.new(getPlayerName)
        @saved_games = getSavedGames
        @game_state = GameState.new
        puts @game_state   .player
        #puts @saved_games
    end
    
    def getSavedGames
        Dir.chdir("saves")
        files = Dir.glob("*")
        Dir.chdir("..")
        #puts files
        return files
    end
    
    def getWord
        word_to_guess = ""
        

        words = File.readlines "5desk.txt"
        got_word = false
        until got_word
            word_to_guess = words[Random.rand(words.length).to_i]
            got_word = true unless (word_to_guess.length < 5 || word_to_guess.length > 11)
        end
        return word_to_guess
    end

    def playGame
        quit_game = false
        game_to_load = Array.new
        if @saved_games.empty?
            startNewGame
        elsif
            cont = true
            puts "There are saved games."
            saved_games.each_with_index do |file, i|
                puts "#{i} - #{file}"
                game_to_load[i] = i.to_s
            end
            puts "If you would like to load one of the saved games,"
            puts "type the number of the game. If you would like to start"
            puts "a new game type N, if you would like to quit type Q"
            while cont
                
                ans = gets.chomp
                puts ans
                if game_to_load.include?(ans)
                    puts "Should load game here."
                    cont = false
                elsif ans === "N"
                    startNewGame
                    cont = false
                elsif ans === "Q"
                    cont = false
                    quit_game = true
                end

            end
        end

        return if quit_game
        puts @game_state.word
        puts @game_state.status
        while @game_state.status === "PLAYING"
            guess = @player.get_letter
            if @game_state.word.include?(guess)
                puts "That was a good guess!"
            end
        end

    end

    def startNewGame
        @game_state.player = @player
        @game_state.word = getWord
        @game_state.status = "PLAYING"
        @game_state.guesses_left = @game_state .word.length + 1
    end
    
    def saveGame

    end

    def loadGame

    end

    def getPlayerName
        puts "What is your name: "
        playerName = gets.chomp
        #return playerName
    end
end

class GameState
    # Word
    # Letters chosen by Player
    # Player object
    # Guesses made
    # Guesses left
    attr_accessor :word, :player, :status, :guesses_left
end

class Player
    # Get name
    # Get guess
    # Save guess to array
    attr_accessor :name
    def initialize(name)
        @name = name
    end

    def get_letter
        puts "Enter a letter: "
        letter = gets.chomp
        #@gussed_letters << letter
        #return letter
    end

    def player_guesses
        return @gussed_letters
    end
end

new_game = Game.new 
new_game.playGame
#puts new_game.getWord