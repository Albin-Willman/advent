#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.split(",").map(&:to_i)
end


ac = AmplifierChain.new

puts ac.find_max_output(input.first)
ac = AmplifierChain.new

puts ac.find_max_output_looped(input.first)
