#!/usr/bin/env ruby
require "./task.rb"

fg = FuelGrid.new(9445)
puts fg.find_best_cell(3..3)
puts fg.find_best_cell(3..299)
