#!/usr/bin/env ruby
require "./task.rb"


test = ['dabAcCaCBAcCcaDA', 'dabCBAcaDA']
res = Reductor.new.run(test[0])
puts res.length
if res == test[1]
  puts 'Yay!'
else
  puts 'Nope!'
end


pi = PolymerImprover.new(test[0])

res = pi.run

if res == 4
  puts 'Yay!'
else
  puts 'Nope!'
end
