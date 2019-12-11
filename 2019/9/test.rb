#!/usr/bin/env ruby
require "../computer.rb"

c = Computer.new([109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99], 'nope')
c.run_till_end

# c = Computer.new([1102,34915192,34915192,7,4,7,99,0], 'nope')
# puts c.run.to_s.length
# puts "#{c.memory}, #{c.relative_base}"


# c = Computer.new([104,1125899906842624,99], 'nope')
# puts c.run
# puts "#{c.memory}, #{c.relative_base}"