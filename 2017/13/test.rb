#!/usr/bin/env ruby
require "./task.rb"


input = [
    '0: 3',
    '1: 2',
    '4: 4',
    '6: 4'
]

fw = Firewall.new(input)
puts fw.compute_severity

puts fw.find_first_free_offset