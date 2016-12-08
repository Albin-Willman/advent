#!/usr/bin/env ruby

data = File.open('data.txt').read
room_sum, target_room  = 0, nil

Struct.new('Room', :key, :value, :identifier, :cipher, :decrypted)

def build_room(line)
  room = Struct::Room.new
  parts = line.split('-')
  room.identifier = parts[0..-2].join('')
  room.cipher = parts[0..-2].join('-')

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

def decrypt(room)
  alphabet   = Array('a'..'z')
  decrypter  = Hash[alphabet.zip(alphabet.rotate(room.value))]
  decrypter['-'] = ' '
  room.decrypted = room.cipher.split('').map do |char|
    decrypter[char]
  end.join('')
  room
end

data.each_line do |line|
  room = build_room(line)
  if valid_room?(room)
    room_sum += room.value
    room = decrypt(room)
    target_room = room if room.decrypted == 'northpole object storage'
  end

end
puts target_room
puts room_sum
