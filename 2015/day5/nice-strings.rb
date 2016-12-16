#!/usr/bin/env ruby

VOWEL_REGEX = /([aeiou])/
DOUBLE_REGEX = /([a-z])\1+/
DOUBLE_PAIR_REGEX = /([a-z][a-z]).{0,}\1+/
NOOPS = ['ab', 'cd', 'pq', 'xy']
ONE_SPEACE_REGEX = /([a-z])([a-z])\1+/

test_cases = [
  { string: 'ugknbfddgicrmopn', expected: true },
  { string: 'aaa', expected: true },
  { string: 'jchzalrnumimnmhp', expected: false },
  { string: 'haegwjzuvuyypxyu', expected: false },
  { string: 'dvszwmarrgswjxmb', expected: false },
]

def is_string_nice?(string)
  return false if string.scan(VOWEL_REGEX).flatten.length < 3
  return false if string.scan(DOUBLE_REGEX).length == 0
  return false if NOOPS.any? { |noop| string.include?(noop) }
  true
end

def is_string_realy_nice?(string)
  return false if string.scan(DOUBLE_PAIR_REGEX).length == 0
  return false if string.scan(ONE_SPEACE_REGEX).length == 0
  true
end

if test_cases.all? do |example|
    is_string_nice?(example[:string]) == example[:expected]
  end
  puts 'Tests are ok'
else
  puts 'Test fails'
end

nice_count, nice_count2 = 0, 0
File.open('data.txt').read.each_line do |line|
  nice_count += 1 if is_string_nice?(line)
  nice_count2 += 1 if is_string_realy_nice?(line)
end

puts "There are #{nice_count} nice string"

puts "\nPart 2"

test_cases2 = [
  { string: 'qjhvhtzxzqqjkmpb', expected: true },
  { string: 'xxyxx', expected: true },
  { string: 'uurcxstgmygtbstg', expected: false },
  { string: 'ieodomkazucvgmuy', expected: false },
]

if test_cases2.all? do |example|
    is_string_realy_nice?(example[:string]) == example[:expected]
  end
  puts 'Tests are ok'
else
  puts 'Test fails'
end


puts "There are #{nice_count2} nice string"

