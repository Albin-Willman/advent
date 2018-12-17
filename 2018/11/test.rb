#!/usr/bin/env ruby
require "./task.rb"


cell_tests = [[3,5,8,4],
[122,79,57,-5],
[217,196,39, 0],
[101,153,71, 4]]

cell_tests.each do |t|
  if FuelCell.new(t[0],t[1]).value(t[2]) == t[3]
    puts 'Yay cell'
  else
    puts 'Noo cell'
  end
end

fg = FuelGrid.new(18)
puts fg.find_best_cell(3..3)

fg = FuelGrid.new(42)
puts fg.find_best_cell(3..3)


fg = FuelGrid.new(18)
puts fg.find_best_cell(1..300)
