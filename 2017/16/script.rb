#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end
input = input.first

d = Dance.new(16)
d.perform(input)
puts "#{d.positions.join('')}"
d2 = Dance.new(16)

dm = DanceMapper.new
circle_length = dm.perform(Dance.new(16), input)


start = d2.positions.join('')
(1_000_000_000%circle_length).times do |i|
    d2.perform(input)
end

puts "#{d2.positions.join('')}"

