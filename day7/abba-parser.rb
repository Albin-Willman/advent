#!/usr/bin/env ruby
data = File.open('data.txt').read
abba_count, ssl_count = 0, 0

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
    return s[i..(i+3)] if is_abba_string?(s[i..(i+3)])
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

def valid_ssl?(snippets)
  bab_prospects, abas = [], []
  snippets.each_with_index do |s, i|
    if i % 2 == 1
      bab_prospects << s
    else
      abas += find_abas(s)
    end
  end
  return false if abas.length == 0
  matching_abas_and_babs?(bab_prospects, abas)
end

def matching_abas_and_babs?(bab_prospects, abas)
  abas.each do |aba|
    bab = "#{aba[1]}#{aba[0]}#{aba[1]}"
    bab_prospects.each do |s|
      return true if s.include?(bab)
    end
  end
  false
end

def find_abas(s)
  abas = []
  (s.length-2).times do |i|
    abas << s[i..(i+2)] if s[i] == s[i + 2] && s[i] != s[i+1]
  end
  abas
end

data.each_line do |line|
  ssl_count += 1 if valid_ssl?(line.split(/\[(.*?)\]/).reject { |s| s.length == 0 })
end

puts ssl_count
