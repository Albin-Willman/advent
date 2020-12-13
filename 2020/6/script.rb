#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

puts Form.evaluate(input, ('a'..'z').to_a)
puts Form.evaluate_b(input, ('a'..'z').to_a)