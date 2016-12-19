require "json"

class Test
    attr_accessor :string, :number
    def initialize(string, number)
        @string = string
        @number = number
    end

    def to_s
        "In A: #{@string}, #{@number}"
    end

    def to_json(*a)
        state = JSON.dump ({
            :string => @string, :number => @number
        })        
    end

    def from_json(str)
        data = JSON.parse(str)
        @string = data['string']
        @number = data['number']
    end
end

t = Test.new('fuck', 32)
puts t.string
puts t.number
File.open("saves/test.json", "w") do |f|
    f.puts t.to_json
end

x = Test.new('', 0)

l = File.readlines "saves/test.json"
x.from_json(l[0])
puts "x:\n"
puts x.to_s
puts "string=#{x.string}"
puts "number=#{x.number}"


