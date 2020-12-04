#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end
puts PassportValidator.validate(input)
puts PassportValidator.validate_b(input)