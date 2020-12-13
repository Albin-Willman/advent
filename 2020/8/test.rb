#!/usr/bin/env ruby
require "./task.rb"


input = [
  'nop +0',
'acc +1',
'jmp +4',
'acc +3',
'jmp -3',
'acc -99',
'acc +1',
'jmp -4',
'acc +6'
]
c = Computer.new
puts c.run(input)

puts ComputerFixer.find_fix(input)