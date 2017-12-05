#!/usr/bin/env ruby
require "./task.rb"


test_data_1 = [
    "5 1 9    5",
    "7 5 3",
    "2 4 6 8"
]

cc1 = ChecksumCalculator.new(DifferenceRowEvaluator.new)
res = cc1.run(test_data_1)

expected = 18
if res == expected
    puts "Easy OK"
else
    puts "Easy error"
end

test_data_2 = [
    "5 9 2 8",
    "9 4 7 3",
    "3 8 6 5"
]


expected = 9

cc2 = ChecksumCalculator.new(DivisibleRowEvaluator.new)

res = cc2.run(test_data_2)

if res == expected
    puts "Hard OK"
else
    puts "Hard error"
end