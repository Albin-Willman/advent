#!/usr/bin/env ruby
require "./task.rb"

test_input = {
    'ne,ne,ne' => 3,
    'ne,ne,sw,sw' => 0,
    'ne,ne,s,s' => 2,
    'se,sw,se,sw,sw' => 3
}


test_input.each do |input, expected|
    hg = HexGrid.new(input)
    res = hg.effective_distance
    if res == expected
        puts "#{input} OK"
    else
        puts "#{input} Error expected #{expected} got #{res} #{hg.steps}"
    end
end
