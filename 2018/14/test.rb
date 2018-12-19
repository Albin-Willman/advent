#!/usr/bin/env ruby
require "./task.rb"


tests = [[9, '5158916779'],
[5, '0124515891'],
[18, '9251071085'],
[2018, '5941429882']]

tests.each do |t|
  res = Cooker.new([3,7]).run(t[0])
  if res == t[1]
    puts 'Yay'
  else
    puts "Doh #{res}, #{t[1]}"
  end
end

tests = [['51589', 9],
['01245', 5],
['92510', 18],
['59414', 2018]]

tests.each do |t|
  res = Cooker.new([3,7]).find(t[0])
  if res == t[1]
    puts 'Yay'
  else
    puts "Doh #{res}, #{t[1]}"
  end
end