#!/usr/bin/env ruby
require "../computer.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input = line.split(",").map(&:to_i)
end
c = Computer.new(input, 1)
puts c.run

c = Computer.new(input, 2)
puts c.run