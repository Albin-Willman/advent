#!/usr/bin/env ruby
require "./task.rb"


weights = [12, 14]

puts fuel_required(12) == 2
puts fuel_required(14) == 2
puts fuel_required(1969) == 654
puts fuel_required(100756) == 33583


puts sum_fuel(weights)


puts total_fuel_required(14) == 2
puts total_fuel_required(1969) == 966
puts total_fuel_required(100756) == 50346