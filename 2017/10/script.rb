#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

split_input = input.first.split(',').map(&:to_i)

kh = KnotHash.new(256)

kh.run(split_input)
data = kh.data

puts "Task 1 solution is: #{data[0]*data[1]}"


kha = KnotHashAdmin.new

puts "Task 2 solution is: #{kha.run(input.first)}"