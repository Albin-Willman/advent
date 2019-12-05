#!/usr/bin/env ruby
require "../computer.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.split(",").map(&:to_i)
end

c = Computer.new(input.first, 1)
c.run

c = Computer.new(input.first, 5)
c.run