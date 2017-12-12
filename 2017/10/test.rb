#!/usr/bin/env ruby
require "./task.rb"


test_input = "3,4,1,5"

kh = KnotHash.new(5)

kh.run(test_input.split(',').map(&:to_i))
puts "#{kh.data} #{kh.current_index}"

ascii_input = []
test_input.each_byte do |c|
    ascii_input << c
end

kha = KnotHashAdmin.new

test_cases = {
    '' => "a2582a3a0e66e6e86e3812dcb672a272",
    "AoC 2017" => "33efeb34ea91902bb2f59c9920caa6cd",
    "1,2,3" => "3efbe78a8d82f29979031a4aa0b16a9d",
    "1,2,4" => "63960835bcdc130f0b66d7ff4f6a5a8e"
}


test_cases.each do |input, expected|
    res = kha.run(input)
    if res.downcase == expected
        puts "#{input} OK"
    else
        puts "#{input} Bad got #{g.value} expected #{expected}"
    end
end