#!/usr/bin/env ruby
require "./task.rb"

input = 'flqrgnkx'
d = Defrager.new(input)
d.run

puts d.count_ones

8.times do |i|
    puts "#{d.grid[i][0..7]}"
end

8.times do |i|
    string = ''
    8.times do |j|
        string += ".. " and next if d.grid[i][j] == 0
        index = d.find_region_index(i,j)
        string += "AA " and next if index == 'AA'
        string += "%02d " % index
    end
    puts string
end

puts d.count_regions