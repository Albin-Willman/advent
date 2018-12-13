#!/usr/bin/env ruby
require "./task.rb"


mg = MarbleGame.new(9, 25)
mg.run
puts mg.players.max

tests = [[10, 1618, 8317],
[13, 7999, 146373],
[17, 1104, 2764],
[21, 6111, 54718],
[30, 5807, 37305]]

tests.each do |t|
  mg = MarbleGame.new(t[0], t[1])
  mg.run
  if mg.players.max == t[2]
    puts 'Yay!'
  else
    puts 'Noooo'
  end
end
