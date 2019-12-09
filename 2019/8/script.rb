#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input = line.split('')
end

layers = split_layers(input, 25, 6)
i = find_layer(layers)

puts layers.length

puts calculate_value(layers[i])

print_image(decode(layers, 25, 6), 6, 25)