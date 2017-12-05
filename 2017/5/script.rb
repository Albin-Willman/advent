#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open('data.txt').read.each_line do |line|
    input << line.to_i
end

ip = InstructionParser.new(ManipulationComputer.new)

puts "Task 1 solution is: #{ip.run(input)}"

ip = InstructionParser.new(AdvancedManipulationComputer.new)

puts "Task 1 solution is: #{ip.run(input)}"
