#!/usr/bin/env ruby
require "./task.rb"


input = ['abc

a
b
c

ab
ac

a
a
a
a

b']

puts Form.evaluate(input, ['a', 'b', 'c', 'x', 'y', 'z'])
puts Form.evaluate_b(input, ['a', 'b', 'c', 'x', 'y', 'z'])