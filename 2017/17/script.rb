#!/usr/bin/env ruby
require "./task.rb"
input = 367


sl = SpinLock.new(input)
sl.take(2017)

puts sl.next_value

ssl = SmartSpinLock.new(input)

ssl.take(50000000)
puts ssl.value

