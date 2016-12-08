#!/usr/bin/env ruby
data = File.open('data.txt').read
abba_count = 0

def valid_abba?(snippets)
  can_be_valid = false
  snippets.each_with_index do |s, i|
    valid_snippet = contains_abba?(s)
    return false if valid_snippet && i % 2 == 1
    can_be_valid = true if valid_snippet
  end
  can_be_valid
end

def contains_abba?(s)
  (s.length-3).times do |i|
    return true if is_abba_string?(s[i..(i+3)])
  end
  false
end

def is_abba_string?(s)
  s[0] == s[3] && s[1] == s[2] && s[0] != s[1]
end

data.each_line do |line|
  abba_count += 1 if valid_abba?(line.split(/\[(.*?)\]/).reject { |s| s.length == 0 })
end

puts abba_count
