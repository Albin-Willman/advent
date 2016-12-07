#!/usr/bin/env ruby

data = File.open('data.txt').read
room_sum  = 0

Struct.new('Room', :key, :value, :identifier)

def build_room(line)
  room = Struct::Room.new
  parts = line.split('-')
  room.identifier = parts[0..-2].join('')

  key_and_value = parts[-1].split('[')
  room.value = key_and_value[0].to_i
  room.key = key_and_value[1][0..4]
  room
end

def valid_room?(room)
  letters = count_letters(room.identifier)
  room.key.split('').each do |key|
    count = letters[key] || 0
    letters[key] = -1
    letters.each do |k, v|
      return false if v > count
    end
  end
  true
end

def count_letters(string)
  arr = string.split('')
  res = Hash.new(0)
  arr.each do |letter|
    res[letter] += 1
  end
  return res
end

data.each_line do |line|
  room = build_room(line)
  room_sum += room.value if valid_room?(room)
end

puts room_sum
