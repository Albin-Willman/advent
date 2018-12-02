#!/usr/bin/env ruby
require "./task.rb"


input = [
  'abcdef',
  'bababc',
  'abbcde',
  'abcccd',
  'aabcdd',
  'abcdee',
  'ababab'
]

input2 = [
  'abcde',
  'fghij',
  'klmno',
  'pqrst',
  'fguij',
  'axcye',
  'wvxyz'
]

puts CrateChecker.new.compute_checksum(input)
puts CrateFinder.new.find_correct(input2)