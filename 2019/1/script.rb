#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.to_i
end

puts sum_fuel(input)

puts total_fuel_sum(input)