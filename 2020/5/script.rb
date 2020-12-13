#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.gsub(/\s/, "")
end

puts AirplaneSeats.find_max(input)
puts AirplaneSeats.find_missing(input)
