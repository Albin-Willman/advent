#!/usr/bin/env ruby

input = ['L4', 'L1', 'R4', 'R1', 'R1', 'L3', 'R5', 'L5', 'L2', 'L3', 'R2', 'R1', 'L4', 'R5', 'R4', 'L2', 'R1', 'R3', 'L5', 'R1', 'L3', 'L2', 'R5', 'L4', 'L5', 'R1', 'R2', 'L1', 'R5', 'L3', 'R2', 'R2', 'L1', 'R5', 'R2', 'L1', 'L1', 'R2', 'L1', 'R1', 'L2', 'L2', 'R4', 'R3', 'R2', 'L3', 'L188', 'L3', 'R2', 'R54', 'R1', 'R1', 'L2', 'L4', 'L3', 'L2', 'R3', 'L1', 'L1', 'R3', 'R5', 'L1', 'R5', 'L1', 'L1', 'R2', 'R4', 'R4', 'L5', 'L4', 'L1', 'R2', 'R4', 'R5', 'L2', 'L3', 'R5', 'L5', 'R1', 'R5', 'L2', 'R4', 'L2', 'L1', 'R4', 'R3', 'R4', 'L4', 'R3', 'L4', 'R78', 'R2', 'L3', 'R188', 'R2', 'R3', 'L2', 'R2', 'R3', 'R1', 'R5', 'R1', 'L1', 'L1', 'R4', 'R2', 'R1', 'R5', 'L1', 'R4', 'L4', 'R2', 'R5', 'L2', 'L5', 'R4', 'L3', 'L2', 'R1', 'R1', 'L5', 'L4', 'R1', 'L5', 'L1', 'L5', 'L1', 'L4', 'L3', 'L5', 'R4', 'R5', 'R2', 'L5', 'R5', 'R5', 'R4', 'R2', 'L1', 'L2', 'R3', 'R5', 'R5', 'R5', 'L2', 'L1', 'R4', 'R3', 'R1', 'L4', 'L2', 'L3', 'R2', 'L3', 'L5', 'L2', 'L2', 'L1', 'L2', 'R5', 'L2', 'L2', 'L3', 'L1', 'R1', 'L4', 'R2', 'L4', 'R3', 'R5', 'R3', 'R4', 'R1', 'R5', 'L3', 'L5', 'L5', 'L3', 'L2', 'L1', 'R3', 'L4', 'R3', 'R2', 'L1', 'R3', 'R1', 'L2', 'R4', 'L3', 'L3', 'L3', 'L1', 'L2']

visited_states, state, found = { '0-0': true }, { x: 0, y: 0, dir: 0 }, false

def changeDirection(dir, change)
  changeDir = change == 'L' ? 1 : -1
  (dir + changeDir) % 4
end

def make_turn(state, step)
  state[:dir] = changeDirection(state[:dir], step[0])
  ret = []
  case state[:dir]
  when 0
    ret = [:y, 1]
  when 1
    ret = [:x, 1]
  when 2
    ret = [:y, -1]
  when 3
    ret = [:x, -1]
  end
  ret
end

input.each do |step|
  direction = make_turn(state, step)
  length = step[1..-1].to_i
  length.times do
    state[direction[0]] += direction[1]
    key = "#{state[:x]}-#{state[:y]}"
    if visited_states[key]
      found = true
      break
    end
    visited_states[key] = true
  end
  break if found
end

puts state[:x].abs + state[:y].abs
