#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.split(",")
end

w = Wires.new
w.add_wire_1(input.first)
w.add_wire_2(input[1])

puts w.distance_to_closest_intersction
puts w.distance_to_closest_intersction_by_wire