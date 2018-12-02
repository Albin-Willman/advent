#!/usr/bin/env ruby
require "./task.rb"
input = []
File.open("data.txt").read.each_line do |line|
    input << line
end

puts FrequenzyChanger.new.run(input)
puts FrequenzyChanger.new.run_until_first_repeat(input)
