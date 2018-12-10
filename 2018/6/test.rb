#!/usr/bin/env ruby
require "./task.rb"


input = [
  '1, 1',
  '1, 6',
  '8, 3',
  '3, 4',
  '5, 5',
  '8, 9'
]
am = AreaMapper.new(input)
res = am.run
# am.grid.each {|row| puts row.join(' ') }

sam = DangerAreaMapper.new(input)


puts sam.run(32)
