#!/usr/bin/env ruby
require "./task.rb"


input = "1,9,10,3,2,3,11,0,99,30,40,50".split(',').map(&:to_i)
c1 = Computer.new(input)
puts c1.run

c2 = Computer.new([1,1,1,4,99,5,6,0,99])
puts c2.run

