#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("test-data.txt").read.each_line do |line|
    input << line
end
puts Task.run(input)

input = []
File.open("test-data-b.txt").read.each_line do |line|
    input << line
end
puts Task.run_b(input)
