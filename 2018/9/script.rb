#!/usr/bin/env ruby
require "./task.rb"

mg = MarbleGame.new(419, 72164)
mg.run
puts mg.players.max

mg = MarbleGame.new(419, 7_216_400)
mg.run
puts mg.players.max