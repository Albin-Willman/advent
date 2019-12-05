#!/usr/bin/env ruby
require "../computer.rb"


c = Computer.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], 1)
c.run
puts "#{c.memory}"