#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open('data.txt').read.each_line do |line|
    input << line
end

pv = PassphraseValidator.new
pc = PassphraseCounter.new(pv)

puts "Task 1 solution is: #{pc.count_valid_phrases(input)}"

apv = AnagramPassphraseValidator.new
pc2 = PassphraseCounter.new(apv)

puts "Task 2 solution is: #{pc2.count_valid_phrases(input)}"