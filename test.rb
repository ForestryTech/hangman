Dir.chdir("saves")
files = Dir.glob("*")
nt = Array.new  
t = [1,2,3,4,5,6,6]
t.each_with_index do |i,x|
    nt[x] = 'X'
end
Dir.chdir("..")
print nt
puts "\n-----"
nt.each {|x| print x}
puts "\n-------"
if files.empty? 
    puts "There are no files"
else
    puts "There are some files"
    files.each_with_index do |file, i|
        puts "#{i} - #{file}"
    end
end

"hello".index('l')
word_to_guess = ""

words = File.readlines "5desk.txt"
got_word = false
until got_word
    word_to_guess = words[Random.rand(words.length).to_i]
    got_word = true unless (word_to_guess.length < 5 || word_to_guess.length > 11)
end
puts "Word: #{word_to_guess}"
word_to_guess.each_char do |x|
    puts "*#{x}*"
end
new_word = word_to_guess.chomp

new_word.each_char {|x| puts "*#{x}-"}

wa = new_word.split("")
wa.each_with_index {|x, i| puts "x=#{x}, i=#{i}"}