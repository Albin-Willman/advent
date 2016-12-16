#!/usr/bin/env ruby

test_data = { disc_space: 20, input: '10000', expected_string: '10000011110010000111', expected_sum: '01100' }


def expand(disc_space, input)
  return input[0..disc_space-1] if input.length >= disc_space
  a = input
  b = a.reverse
  b.gsub!('1', '2')
  b.gsub!('0', '1')
  b.gsub!('2', '0')

  expand(disc_space, "#{a}0#{b}")
end

def check_sum(string)
  res = string.scan(/../).map do |p, i|
    p[0] == p[1] ? '1' : '0'
  end.join('')
  res.length % 2 == 0 ? check_sum(res) : res
end

def evaluate(disc_space, input)
  check_sum(expand(disc_space, input))
end

if expand(test_data[:disc_space], test_data[:input]) == test_data[:expected_string]
  puts 'Test 1 ok'
else
  puts 'Bad string test'
end

if evaluate(test_data[:disc_space], test_data[:input]) == test_data[:expected_sum]
  puts 'Test 2 ok'
else
  puts 'Bad sum test'
end

puts evaluate(272, '01000100010010111')
puts evaluate(35651584, '01000100010010111')

