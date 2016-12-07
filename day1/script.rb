#!/usr/bin/env ruby

input = ['L4', 'L1', 'R4', 'R1', 'R1', 'L3', 'R5', 'L5', 'L2', 'L3', 'R2', 'R1', 'L4', 'R5', 'R4', 'L2', 'R1', 'R3', 'L5', 'R1', 'L3', 'L2', 'R5', 'L4', 'L5', 'R1', 'R2', 'L1', 'R5', 'L3', 'R2', 'R2', 'L1', 'R5', 'R2', 'L1', 'L1', 'R2', 'L1', 'R1', 'L2', 'L2', 'R4', 'R3', 'R2', 'L3', 'L188', 'L3', 'R2', 'R54', 'R1', 'R1', 'L2', 'L4', 'L3', 'L2', 'R3', 'L1', 'L1', 'R3', 'R5', 'L1', 'R5', 'L1', 'L1', 'R2', 'R4', 'R4', 'L5', 'L4', 'L1', 'R2', 'R4', 'R5', 'L2', 'L3', 'R5', 'L5', 'R1', 'R5', 'L2', 'R4', 'L2', 'L1', 'R4', 'R3', 'R4', 'L4', 'R3', 'L4', 'R78', 'R2', 'L3', 'R188', 'R2', 'R3', 'L2', 'R2', 'R3', 'R1', 'R5', 'R1', 'L1', 'L1', 'R4', 'R2', 'R1', 'R5', 'L1', 'R4', 'L4', 'R2', 'R5', 'L2', 'L5', 'R4', 'L3', 'L2', 'R1', 'R1', 'L5', 'L4', 'R1', 'L5', 'L1', 'L5', 'L1', 'L4', 'L3', 'L5', 'R4', 'R5', 'R2', 'L5', 'R5', 'R5', 'R4', 'R2', 'L1', 'L2', 'R3', 'R5', 'R5', 'R5', 'L2', 'L1', 'R4', 'R3', 'R1', 'L4', 'L2', 'L3', 'R2', 'L3', 'L5', 'L2', 'L2', 'L1', 'L2', 'R5', 'L2', 'L2', 'L3', 'L1', 'R1', 'L4', 'R2', 'L4', 'R3', 'R5', 'R3', 'R4', 'R1', 'R5', 'L3', 'L5', 'L5', 'L3', 'L2', 'L1', 'R3', 'L4', 'R3', 'R2', 'L1', 'R3', 'R1', 'L2', 'R4', 'L3', 'L3', 'L3', 'L1', 'L2']

state = {
  x: 0,
  y: 0,
  dir: 0
}

def changeDirection(dir, change)
  changeDir = change == 'L' ? 1 : -1
  (dir + changeDir) % 4
end

input.each do |step|
  state[:dir] = changeDirection(state[:dir], step[0])
  length = step[1..-1].to_i
  case state[:dir]
  when 0
    state[:y] += length
  when 1
    state[:x] += length
  when 2
    state[:y] -= length
  when 3
    state[:x] -= length
  end
  puts state
end


