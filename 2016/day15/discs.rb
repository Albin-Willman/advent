#!/usr/bin/env ruby

class Disc
  attr_accessor :lag, :positions, :start
  def initialize(lag, positions, start)
    @lag, @positions, @start = lag, positions, start
  end

  def valid_start?(n)
    (lag + n + start) % positions == 0
  end
end

discs = []
part2 = true
# File.open('test.txt').read.each_line do |line|
File.open('data.txt').read.each_line do |line|
  disc_data = line.scan(/\d+/).map(&:to_i)
  discs << Disc.new(disc_data[0], disc_data[1], disc_data[3])
end

if part2
  discs << Disc.new(discs[-1].lag + 1, 11, 0)
end

time = 0

while true
  if discs.all? { |d| d.valid_start?(time) }
    puts time
    break
  end
  time += 1
end
