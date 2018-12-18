#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.gsub(/\s+/, "")
end


p = Pots.new(input[0], input[2..-1], 20)
p.run
puts p.value


puts (45120 + (50000000000 - 1000)*45)