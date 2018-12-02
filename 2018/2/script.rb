#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

puts CrateChecker.new.compute_checksum(input)
puts CrateFinder.new.find_correct(input)
