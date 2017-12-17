#!/usr/bin/env ruby
require "./task.rb"

d = Dance.new(5)
d.perform('s1,x3/4,pe/b')
puts "#{d.positions}"