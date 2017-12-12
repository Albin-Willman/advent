#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

input = input.first
hg = HexGrid.new(input)
puts "Task 1 solution is: #{hg.effective_distance}"

max = 0

split_input = input.split(',')

split_input.length.times do |i|
    hg = HexGrid.new(split_input[0..i])
    distance = hg.effective_distance
    max = [max, distance].max
end

puts "Task 2 solution is: #{max}"