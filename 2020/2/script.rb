#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

pw = PasswordValidator.new
puts pw.validate_list(input)
puts pw.validate_list_b(input)