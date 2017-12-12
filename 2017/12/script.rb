#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

p = Plumber.new(input)
p.group_all

puts "Task 1 solution is: #{p.count_group_members('0')}"

puts "Task 2 solution is: #{p.count_groups}"