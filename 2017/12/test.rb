#!/usr/bin/env ruby
require "./task.rb"


input = [
    '0 <-> 2',
    '1 <-> 1',
    '2 <-> 0, 3, 4',
    '3 <-> 2, 4',
    '4 <-> 2, 3, 6',
    '5 <-> 6',
    '6 <-> 4, 5'
]

p = Plumber.new(input)
p.group_all
puts p.count_group_members('0')
puts p.count_groups