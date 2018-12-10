#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end


# am = AreaMapper.new(input)
# am.run
# puts "#{am.corners}"
# am.grid.each {|row| puts row.join(' ') }

# puts "#{res.id}: #{res.area} #{res.x} #{res.y}"
sam = DangerAreaMapper.new(input)

puts sam.run(10000)