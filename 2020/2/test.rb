#!/usr/bin/env ruby
require "./task.rb"


input = [
"1-3 a: abcde",
"1-3 b: cdefg",
"2-9 c: ccccccccc"
]

pw = PasswordValidator.new
puts pw.validate_list(input)
puts pw.validate_list_b(input)