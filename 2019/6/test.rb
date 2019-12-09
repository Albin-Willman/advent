#!/usr/bin/env ruby
require "./task.rb"

input = [
'COM)B',
'B)C',
'C)D',
'D)E',
'E)F',
'B)G',
'G)H',
'D)I',
'E)J',
'J)K',
'K)L'
]

om = OrbitMap.new
om.read_map(input)

puts om.find_closest_path(om.find_or_init('L'), om.find_or_init('I'))