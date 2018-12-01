#!/usr/bin/env ruby
require "./task.rb"


input = [
    'set a 1',
    'add a 2',
    'mul a a',
    'mod a 5',
    'snd a',
    'set a 0',
    'rcv a',
    'jgz a -1',
    'set a 1',
    'jgz a -2'
]


d = Duet.new
puts d.play(input)