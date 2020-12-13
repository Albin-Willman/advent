#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("test-data.txt").read.each_line do |line|
    input << line
end
puts Task.run(input)
t = Task.new
puts t.run_b(input)
