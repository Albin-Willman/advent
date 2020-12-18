#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("test-data.txt").read.each_line do |line|
    input << line
end
input.each do |c|
  parts = c.split(' = ')
  puts "#{Task.run(parts[0], 2020)}, #{Task.run(parts[0], 30000000)}, #{parts[1]}"
end
