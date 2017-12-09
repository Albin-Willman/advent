#!/usr/bin/env ruby
require "./task.rb"

test_input = "0 2 7 0".gsub(/\s+/m, ' ').strip.split(" ").map(&:to_i)

m = Memory.new

puts m.realocate(test_input)