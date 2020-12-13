#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

puts Task.run(input, 25)
puts Task.run_b(input, 25)