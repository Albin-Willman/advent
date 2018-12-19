#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end


cm = CartMap.new(input)

puts "#{cm.carts}"
# puts "#{cm.grid}"

puts cm.find_first_collision

cm = CartMap.new(input)
puts cm.find_last_cart