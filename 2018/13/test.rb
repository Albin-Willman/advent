#!/usr/bin/env ruby
require "./task.rb"

input = ['/->-\        ',
'|   |  /----\\',
'| /-+--+-\  |',
'| | |  | v  |',
'\-+-/  \-+--/',
'  \------/   ']

cm = CartMap.new(input)

# puts "#{cm.carts}"
# puts "#{cm.grid}"

puts cm.find_first_collision.first


input = [
  '/>-<\  ',
  '|   |  ',
  '| /<+-\\',
  '| | | v',
  '\>+</ |',
  '  |   ^',
  '  \<->/'
]

cm = CartMap.new(input)

# puts "#{cm.carts}"
# puts "#{cm.grid}"

puts cm.find_last_cart