#!/usr/bin/env ruby
require "./task.rb"


input1 = 256310
input2 = 732736

pv = PasswordValidator.new
puts pv.count_passwords(input1, input2)


