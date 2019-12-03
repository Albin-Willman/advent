#!/usr/bin/env ruby
require "./task.rb"


w = Wires.new

w.add_wire_1(["R8","U5","L5","D3"])
w.add_wire_2(["U7","R6","D4","L4"])

puts w.distance_to_closest_intersction
w = Wires.new

w.add_wire_1 "R75,D30,R83,U83,L12,D49,R71,U7,L72".split(",")
w.add_wire_2 "U62,R66,U55,R34,D71,R55,D58,R83".split(",")



puts w.distance_to_closest_intersction
puts w.distance_to_closest_intersction_by_wire
