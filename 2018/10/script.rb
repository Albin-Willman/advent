#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

sm = StarMap.new(input, 400, 250)
time = 10500
sm.fast_forward(time)

option = 'y'
while option != 'n'
  sm.step
  time += 1
  puts 'Step? (y/n)'
  option = gets.chomp
end

puts time