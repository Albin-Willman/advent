#!/usr/bin/env ruby
require "./task.rb"

test_input = [
0,
3,
0,
1,
-3,
]
ip = InstructionParser.new(ManipulationComputer.new)

puts ip.run(test_input)

ip = InstructionParser.new(AdvancedManipulationComputer.new)

puts ip.run(test_input)