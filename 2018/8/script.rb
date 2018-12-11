#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

input = input.first.split(' ').map(&:to_i)

MetaFinder.new(input).run
