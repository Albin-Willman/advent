#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line.split('')
end

am = AstroidMap.new(input)
am.compute_visibility

am.place_laser
puts am.laser.number_of_visible_astroids

am.vaporize(200)

a = am.vaporized_astroids.last
puts "#{a.x}-#{a.y}"