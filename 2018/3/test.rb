#!/usr/bin/env ruby
require "./task.rb"


input = [
  '#1 @ 1,3: 4x4',
  '#2 @ 3,1: 4x4',
  '#3 @ 5,5: 2x2'
]
fm = FabricMapper.new(input)
puts fm.count_overlaps
puts fm.unsulieds


