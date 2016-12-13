#!/usr/bin/env ruby

total, ribon = 0, 0

def parse(line)
  line.split('x').map(&:to_i)
end

def calculate(arr)
  sides = arr.combination(2).map { |s| s[0] * s[1] }
  sides.inject(0, :+) * 2 + sides.min
end

def calculate_ribon(arr)
  arr.inject(1, :*) + (arr.inject(0 ,:+) - arr.max) * 2
end

File.open('data.txt').read.each_line do |line|
# ['2x3x4'].each do |line|
  arr = parse(line)
  total += calculate(arr)
  ribon += calculate_ribon(arr)
end

puts total
puts ribon
