#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

c = Computer.new
puts c.run(input)
puts ComputerFixer.find_fix(input)