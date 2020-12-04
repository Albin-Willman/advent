#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.gsub(/\s/, "")
end

puts Slope.descend(input, 1, 3)
slopes = [
  [1, 1],
  [1, 3],
  [1, 5],
  [1, 7],
  [2, 1],
]

puts Slope.check_slopes(input, slopes)