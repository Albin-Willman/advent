#!/usr/bin/env ruby

File.open('data.txt').read.each_line do |line|
  line.gsub!(/\s+/, '')
  total_length = line.length
  line.gsub!(/#{Regexp.quote('(')}/, '')
  steps_down = line.length
  puts total_length - 2*steps_down
end

File.open('data.txt').read.each_line do |line|
  arr = line.gsub(/\s+/, '').split('')
  counter = 0
  arr.each_with_index do |c, i|
    counter += (c == '(' ? 1 : -1)
    puts counter
    if counter == -1
      puts i + 1
      break
    end
  end
end
