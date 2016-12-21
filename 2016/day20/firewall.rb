#!/usr/bin/env ruby

input = [
  '5-8',
  '0-2',
  '4-9'
]

input2 = [
  '5-8',
  '0-2',
  '4-7'
]


def to_range(s)
  arr = s.scan(/\d+/).map(&:to_i)
  (arr[0]..arr[1])
end

def search_for_smallest(ranges)
  last = 0
  ranges = reduce_ranges(ranges)
  ranges.each do |range|
    return last if range.first > last
    last = range.last + 1
  end
end

def search_for_gaps(ranges, start, finish)
  gaps = []
  ranges = reduce_ranges(ranges)
  last = start
  ranges.each do |range|
    gaps << (last..(range.first - 1)) if range.first > last
    last = range.last + 1
  end
  gaps << (last..finish) if (finish + 1) > last
  gaps
end

def count_gaps(gaps)
  sum = 0
  gaps.each do |gap|
    length = gap.last - gap.first + 1
    sum += length
  end
  sum
end

def reduce_ranges(ranges)
  ranges.sort! do |a, b|
    a.first <=> b.first
  end
  new_ranges = []
  ranges.each_with_index do |range, i|
    next if range == nil
    start = range.first
    last = range.last
    ranges.each_with_index do |sub_range, j|
      next if sub_range == nil || i == j
      break if sub_range.first > last
      last = [last, sub_range.last].max
      ranges[j] = nil
    end
    ranges[i] = nil
    new_ranges << (start..last)
  end
  new_ranges
end



ranges = input.map { |s| to_range(s) }

puts search_for_smallest(ranges)
# puts '&&&&'
ranges = input2.map { |s| to_range(s) }
puts count_gaps(search_for_gaps(ranges, 0, 9))
# puts '&&&&'

ranges_real = []

File.open('data.txt').read.each_line do |line|
  ranges_real << to_range(line)
end

puts search_for_smallest(ranges_real.clone)
puts count_gaps(search_for_gaps(ranges_real, 0, 4294967295))


