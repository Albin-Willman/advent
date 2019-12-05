#!/usr/bin/env ruby
require "../computer.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input = line.split(',').map(&:to_i)
end
input[1] = 12
input[2] = 2

c1 = Computer.new(input, 0)

puts c1.run

def find_result(expected, input)
	(0..99).each do |noun|
		(0..99).each do |verb|
			input[1] = noun
			input[2] = verb
			c = Computer.new(input, 0)
			res = c.run
			return 100*noun + verb if res == expected
		end
	end
end
puts find_result(4023471, input)
puts find_result(19690720, input)
