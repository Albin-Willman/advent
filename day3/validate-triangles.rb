#!/usr/bin/env ruby

def new_batch
  [[], [], []]
end

possible_triangles, triangles = 0, new_batch

def valid_triangle?(trio)
  trio.map!(&:to_i).sort!
  trio[2] < (trio[1] + trio[0])
end



File.open('data.txt').read.each_line.with_index do |line, i|
  line_data = line.split(' ')
  line_data.each_with_index { |p, i| triangles[i] << p }
  if i % 3 == 2
    triangles.each do |triangle|
      possible_triangles += 1 if valid_triangle?(triangle)
    end
    triangles = new_batch
  end
end

puts possible_triangles
