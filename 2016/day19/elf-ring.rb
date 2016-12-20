#!/usr/bin/env ruby
input = 5
# input = 10
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


# puts reduce(arr)
# puts linear_2(arr)