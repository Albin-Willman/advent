#!/usr/bin/env ruby
require "./task.rb"


sd = SpiralDistance.new


easy_test_data = {
    1 => 0,
    12 => 3,
    23 => 2,
    1024 => 31
}
easy_test_data.each do |input, expected|
    if sd.run(input) == expected
        puts "Easy ok. #{input}"
    else
        puts "Easy error. #{input}"
    end
end


sw = SpiralWriter.new
res = sw.run(24)
puts "#{sw.data}"