#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end


omf = OptimalMinuteFinder.new(input)
res1 = omf.strategy_1
puts res1
puts "Answer 1: #{res1[0].to_i * res1[1].to_i}"

res2 = omf.strategy_2
puts res2
puts "Answer 2: #{res2[0].to_i * res2[1].to_i}"
