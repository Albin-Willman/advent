#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open('data.txt').read.each_line do |line|
    input << line
end

c = Computer.new

res = c.run(input)

puts "Task 1 solution is: #{c.current_high}"
puts "Task 2 solution is: #{c.highest_value}"
