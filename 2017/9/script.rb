#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

g = Group.new(input.first)
puts "Task 1 solution is: #{g.value}"


gf = GarbageFinder.new
res = gf.count_amount_of_garbage(input.first)
puts "Task 2 solution is: #{res}"