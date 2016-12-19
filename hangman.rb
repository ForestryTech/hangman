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
        #@game_state.alphabet_array = Array.new
        #@game_state.letters_guessed = Array.new
        #puts @game_state.player
        #puts @saved_games
    end
    
    def getSavedGames
        Dir.chdir("saves")
        files = Dir.glob("*")
        Dir.chdir("..")
        #puts files
        return files
    end
    
    def initializeArrays
        @game_state.alphabet_array = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        @game_state.word.each_char {|x| @game_state.letters_guessed << "_"}
    end

    def getWord
        word_to_guess = ""

        words = File.readlines "5desk.txt"
        got_word = false
        until got_word
            word_to_guess = words[Random.rand(words.length).to_i]
            got_word = true unless (word_to_guess.length < 5 || word_to_guess.length > 11)
        end
        word_to_guess.chomp!
        return word_to_guess.downcase
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
                
                ans = gets.chomp.upcase
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
        #puts @game_state.word
        word_len = @game_state.word.length
        #puts "Length of word: #{word_len}"
        #puts @game_state.status
        guess_made = 0
        guess_left = @game_state.word.length
        guess = ""
        while @game_state.status === "PLAYING"
            puts "Make a guess. The letters left are: "
            print_letters_left(guess)
            puts "There are #{guess_left} wrong guesses left."
        
            
            puts "\n-------------------------------------"
            guess = @player.get_letter.downcase
            
            if @game_state.word.include?(guess)
                puts "That was a good guess!"
            else
                puts "#{guess} was not in the word."
                guess_made = guess_made + 1
                
            end
            guess_left = word_len - guess_made
            
            print_letters_guessed(guess)
            @game_state.status = "WON" unless @game_state.letters_guessed.include?("_")

            
            if guess_made >= word_len
                @game_state.status = "LOST"
                
            end
        end

        if @game_state.status === "WON"
            puts "Congratulations! You Won!"
        else
            puts "Sorry, you did not guess the word.\nThe word is #{@game_state.word}"
        end

    end
    
    def print_letters_left(guess)
        @game_state.alphabet_array.each_index do |i|
            if @game_state.alphabet_array[i] === guess
                @game_state.alphabet_array[i] = '*'
            end
            print "#{@game_state.alphabet_array[i]} "
        end
        puts "\n-----------------------------------------------"
    end
    def print_letters_guessed(guess)
        word_array = @game_state.word.split("")
        word_array.each_with_index do |letter, i|
            if letter === guess
                @game_state.letters_guessed[i] = guess
            end
        end
        puts "Letters guessed so far."
        @game_state.letters_guessed.each {|letter| print letter}
        puts
    end

    def startNewGame
        @game_state.player = @player
        @game_state.word = getWord
        @game_state.status = "PLAYING"
        @game_state.guesses_left = @game_state .word.length + 1
        initializeArrays
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
    attr_accessor :word, :player, :status, :guesses_left, :letters_guessed, :alphabet_array, :player_name

    def initialize
        @letters_guessed = Array.new
        @alphabet_array = Array.new
    end

    def to_json
        state_of_game = JSON.dump ({
            :word => @word, :player_name => @player_name,
            :status => @status, :guesses_left => @guesses_left,
            :letters_guessed => @letters_guessed.join(","), :alphabet_array => @alphabet_array.join(",")
        })

        return state_of_game
    end

    def from_json(str)
        data = JSON.parse(str)
        @word = data['word']
        @player_name = data['player_name']
        @status = data['status']
        @guesses_left = data['guesses_left']
        @letters_guessed = data['letters_guessed'].split(",")
        @alphabet_array = data['alphabet_array'].split(",")
        @player = Player.new(@player_name)
    end
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