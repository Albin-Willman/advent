#!/usr/bin/env ruby

data = File.open('data.txt').read
possible_triangles  = 0

def valid_triangle?(trio)
  trio.map!(&:to_i).sort!
  trio[2] < (trio[1] + trio[0])
end

data.each_line do |line|
  possible_triangles += 1 if valid_triangle?(line.split(' '))
end

puts possible_triangles
