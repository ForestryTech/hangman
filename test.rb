Dir.chdir("saves")
files = Dir.glob("*")

if files.empty? 
    puts "There are no files"
else
    puts "There are some files"
    files.each_with_index do |file, i|
        puts "#{i} - #{file}"
    end
end