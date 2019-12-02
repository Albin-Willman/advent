#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input = line.split(',').map(&:to_i)
end

c1 = Computer.new(input, 12, 2)

puts c1.run

def find_result(expected, input)
	(0..99).each do |noun|
		(0..99).each do |verb|
			c = Computer.new(input, noun, verb)
			res = c.run
			puts res
			return 100*noun + verb if res == expected
		end
	end
end
puts find_result(4023471, input)
puts find_result(19690720, input)
