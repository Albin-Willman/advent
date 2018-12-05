#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

res = Reductor.new.run(input[0])
puts res.length

pi = PolymerImprover.new(res)
puts pi.run
