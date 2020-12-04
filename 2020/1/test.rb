#!/usr/bin/env ruby
require "./task.rb"

input = [1721,
979,
366,
299,
675,
1456]

nf = NumberFinder.new
puts nf.run(input, 2)
puts nf.run(input, 3)