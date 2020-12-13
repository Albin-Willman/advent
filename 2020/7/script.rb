#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

bc = BagCounter.new(input)
puts bc.how_many_can_contain?('shiny gold')
puts bc.how_many_inside('shiny gold')
