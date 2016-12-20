#!/usr/bin/env ruby
input = 5
# input = 3005290
arr = (1..input).to_a

def reduce(arr)
  return arr[0] if arr.length == 1
  length = arr.length
  length.times do |i|
    next if arr[i] == 0
    arr[(i+1)%length] = 0
  end
  reduce(arr.reject { |e| e == 0})
end


def linear_2(arr)
  length = arr.length
  current = 0
  (length-1).times do |i|
    puts length if length % 5000 == 0
    index = (current + length/2) % length
    arr.delete_at(index)
    length -= 1
    current = (index > current ? current + 1 : current)%length
  end
  arr[0]
end

100.times do |i|
  elves = i + 1
  arr = (1..elves).to_a
  res = linear_2(arr)
  last_reset, next_reset, guess = 0, 0, 0
  15.times do |j|
    next_reset = (3**j)
    break if next_reset > (elves)
    last_reset = next_reset
  end
  guess =  elves - last_reset + [elves*2 - last_reset - next_reset, 0].max/2
  guess = last_reset if guess == 0
  puts "res #{elves} -> #{res}, #{guess} "
end


elf = 3005290
last_reset, next_reset, guess = 0, 0, 0
15.times do |j|
  next_reset = (3**j)
  break if next_reset > (elf)
  last_reset = next_reset
end

guess =  elf - last_reset + [elf*2 - last_reset - next_reset, 0].max/2
guess = last_reset if guess == 0
puts guess
