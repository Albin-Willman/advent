#!/usr/bin/env ruby

data = File.open('data.txt').read
possibilities = ['']*8

def find_most_frequent(arr)
  freq = arr.reduce(Hash.new(0)) { |h, v| h[v] += 1; h }.max_by{ |k,v| v }
  freq[0]

end

data.each_line do |line|
  line.gsub(/\s+/, "").split('').each_with_index do |letter, i|
    possibilities[i] += letter
  end
end

puts possibilities[0..7].map { |p| find_most_frequent(p.split('')) }.join

