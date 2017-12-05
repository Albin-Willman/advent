#!/usr/bin/env ruby
require "./task.rb"

sd = SpiralDistance.new
input = 325489

puts "Task 1 solution is: #{sd.run(input)}"

sw = SpiralWriter.new
puts "Task 2 solution is: #{sw.run(input)}"
