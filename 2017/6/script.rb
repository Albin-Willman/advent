#!/usr/bin/env ruby
require "./task.rb"
input = ''
File.open('data.txt').read.each_line do |line|
    input = line.gsub(/\s+/m, ' ').strip.split(" ").map(&:to_i)
end

m = Memory.new

puts "Task 1 and 2 solution is: #{m.realocate(input)}"

