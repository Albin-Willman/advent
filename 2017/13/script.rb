#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

fw = Firewall.new(input)

puts "Task 1 solution is: #{fw.compute_severity}"

puts "Task 2 solution is: #{fw.find_first_free_offset}"