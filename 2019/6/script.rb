#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.gsub(/\s+/, "")
end

om = OrbitMap.new
om.read_map(input)


puts om.map_value
puts om.find_closest_path(om.find_or_init('YOU'), om.find_or_init('SAN'))