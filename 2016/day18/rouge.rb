#!/usr/bin/env ruby

class Room
  attr_accessor :rows, :first_row, :num_rows, :num_safe_tiles
  def initialize(first_row, num_rows)
    @first_row = translate(first_row)
    @rows = [@first_row]
    @num_rows = num_rows
  end

  def traverse(complete = true)
    @num_safe_tiles = 0
    unless complete
      prev = first_row
      @num_safe_tiles += prev.inject(0, :+)
      (2..num_rows).each do |i|
        prev = build_row(prev)
        @num_safe_tiles += prev.inject(0, :+)
      end
    else
      while @rows.length < @num_rows
        @rows << build_row(@rows[-1])
      end
      @num_safe_tiles = calc_num_safe_tiles
    end
  end

  def build_row(prev_row)
    row = []
    prev_row.length.times do |i|
      row << (is_safe?(prev_row, i) ? 1 : 0)
    end
    row
  end

  def is_safe?(prev, i)
    left = i == 0 ? 1 : prev[i-1]
    center = prev[i]
    right = prev[i+1] || 1
    sum = left + center + right
    return true if sum == 3 || sum == 0
    return true if sum == 2 && center == 0
    return true if sum == 1 && center == 1
    false
  end

  def calc_num_safe_tiles
    @rows.reduce(:+).inject(0, :+)
  end

  def translate(input)
    input.split('').map { |e| e == '.' ? 1 : 0 }
  end

  def print
    rows.each do |row|
      puts row.map { |e| e == 1 ? '.' : '^' }.join('')
    end
  end
end

r = Room.new('..^^.', 3)
r.traverse
r.print
puts r.num_safe_tiles

r = Room.new('.^^.^.^^^^', 10)
r.traverse
r.print
puts r.num_safe_tiles

r = Room.new('.^..^....^....^^.^^.^.^^.^.....^.^..^...^^^^^^.^^^^.^.^^^^^^^.^^^^^..^.^^^.^^..^.^^.^....^.^...^^.^.', 40)
r.traverse
r.print
puts r.num_safe_tiles
r.traverse(false)
puts r.num_safe_tiles

r = Room.new('.^..^....^....^^.^^.^.^^.^.....^.^..^...^^^^^^.^^^^.^.^^^^^^^.^^^^^..^.^^^.^^..^.^^.^....^.^...^^.^.', 400000)
r.traverse(false)
puts r.num_safe_tiles



