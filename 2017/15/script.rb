#!/usr/bin/env ruby
require "./task.rb"

generator_a_setting = 16807
input_a = 883
input_b = 879
generator_b_setting = 48271

common_setting = 2147483647

# a = Generator.new(generator_a_setting, common_setting, input_a)
# b = Generator.new(generator_b_setting, common_setting, input_b)

# judge = Judge.new(a, b)
# judge.run(40_000_000)

# puts "Task 1 solution is: #{judge.pairs}"

a2 = Generator.new(generator_a_setting, common_setting, input_a, 4)
b2 = Generator.new(generator_b_setting, common_setting, input_b, 8)

judge2 = Judge.new(a2, b2)
judge2.run(5_000_000)

puts "Task 2 solution is: #{judge2.pairs}"