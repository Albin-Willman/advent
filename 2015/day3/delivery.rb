#!/usr/bin/env ruby

positions = {}

def parse(line)

end

class Santa
  attr_accessor :houses, :position
  def initialize
    @position = [0, 0]
    @houses = Hash.new(0)
    visit_house
  end

  def visit_house
    houses[position.join('-')] += 1
  end

  def move(dir)
    case dir
    when '^'
      position[1] += 1
    when 'v'
      position[1] -= 1
    when '>'
      position[0] += 1
    when '<'
      position[0] -= 1
    end
    visit_house
  end

  def follow(instructions)
    instructions.split('').each { |d| move(d) }
  end

  def num_houses
    houses.length
  end
end

s = Santa.new


File.open('data.txt').read.each_line do |line|
  line.gsub!(/\s+/, '')
  s.follow(line)
end
puts s.num_houses


# part2
s2 = Santa.new
rs = Santa.new

File.open('data.txt').read.each_line do |line|
  line.gsub!(/\s+/, '')
  line.split('').each_with_index do |d, i|
    if i % 2 == 0
      s2.move(d)
    else
      rs.move(d)
    end
  end
end

puts s2.houses.merge(rs.houses).length
