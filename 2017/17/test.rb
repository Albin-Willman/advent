#!/usr/bin/env ruby
require "./task.rb"


sl = SpinLock.new(3)

sl.take(2017)
puts sl.next_value

ssl = SmartSpinLock.new(3)

ssl.take(50000000)
puts ssl.value