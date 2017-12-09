#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open('data.txt').read.each_line do |line|
    input << line
end


rt = RecursiveTree.new(input)

puts "Task 1 solution is: #{rt.find_root.name}"
rt.build_tree


puts "Task 2 solution is: #{rt.find_correct_weight}"