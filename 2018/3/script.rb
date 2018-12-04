#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

fm = FabricMapper.new(input)
puts fm.count_overlaps
puts fm.unsulieds