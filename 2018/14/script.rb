#!/usr/bin/env ruby
require "./task.rb"

puts Cooker.new([3,7]).run(920_831)

puts Cooker.new([3,7]).find('920831')