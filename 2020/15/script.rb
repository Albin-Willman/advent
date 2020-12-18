#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end
puts Task.run(input.first, 2020)
puts Task.run(input.first, 30000000)
