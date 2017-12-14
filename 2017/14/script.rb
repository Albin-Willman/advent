#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

d = Defrager.new(input.first)
start = Time.now
d.run
finish = Time.now

puts "Task 1 solution is: #{d.count_ones}"
puts "Task 2 solution is: #{d.count_regions}"
puts "Time #{finish - start}"

