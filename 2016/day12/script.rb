#!/usr/bin/env ruby

require './computer.rb'

lines = [
  'cpy 41 a',
  'inc a',
  'inc a',
  'dec a',
  'jnz a 2',
  'dec a'
]

parser = Parser.new
# cmds = lines.map { |line| parser.parse(line) }
cmds = []
File.open('data.txt').read.each_line do |line|
  cmds << parser.parse(line.gsub(/\n/, ""))
end
puts cmds

c = Computer.new
c.execute(cmds)

puts c.registers[:a]

