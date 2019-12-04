#!/usr/bin/env ruby
require "./task.rb"

pv = PasswordValidator.new
# puts pv.valid?(111_111)
# puts pv.valid?(223450)
# puts pv.valid?(123789)

puts pv.valid? 112233
