#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open('data.txt').read.each_line do |line|
    input << line
end

cc1 = ChecksumCalculator.new(DifferenceRowEvaluator.new)
puts "Task 1 solution is: #{cc1.run(input)}"

cc2 = ChecksumCalculator.new(DivisibleRowEvaluator.new)
puts "Task 2 solution is: #{cc2.run(input)}"