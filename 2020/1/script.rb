#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.to_i
end

nf = NumberFinder.new
puts nf.run(input, 2)
puts nf.run(input, 3)