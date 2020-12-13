#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("test_data.txt").read.each_line do |line|
    input << line
end

puts Task.run(input, 5)
puts Task.run_b(input, 5)
