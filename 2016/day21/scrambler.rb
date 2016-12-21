#!/usr/bin/env ruby

class Scrambler
  attr_accessor :password, :parser
  def initialize(input)
    @parser = Parser.new
    @password = input.split('')
  end

  def exectute(cmd)
    instruction = parser.interpret(cmd)
    send(instruction[:type], instruction[:payload]) if instruction
  end

  def output
    password.join('')
  end

  private

  def swap_pos(positions)
    tmp = password[positions[0]]
    password[positions[0]] = password[positions[1]]
    password[positions[1]] = tmp
  end

  def swap_letters(letters)
    index0 = password.index(letters[0])
    index1 = password.index(letters[1])
    password[index0] = letters[1]
    password[index1] = letters[0]
  end

  def reverse(indices)
    parts = []
    parts << password[0..(indices[0]-1)] unless indices[0] == 0
    parts << password[indices[0]..indices[1]].reverse
    parts << password[(indices[1]+1)..-1] unless (indices[1]+1) == password.length
    @password = parts.flatten
  end

  def rotate(steps)
    @password.rotate!(steps)
  end

  def index_rotate(letter)
    steps = password.index(letter)
    steps += 1 if steps >= 4
    steps += 1
    @password.rotate!(-steps)
  end

  def rotate(steps)
    @password.rotate!(steps)
  end

  def move(indices)
    do_move(indices)
  end

  def do_move(indices)
    part = @password.delete_at(indices[0])
    parts = []
    parts << password[0..(indices[1]-1)] unless indices[1] == 0
    parts << part
    parts << password[(indices[1])..-1] unless (indices[1]) == password.length
    @password = parts.flatten
  end
end

class Descrambler < Scrambler
  def rotate(steps)
    @password.rotate!(-steps)
  end

  def index_rotate(letter)
    new_index = password.index(letter)
    new_index = password.length if new_index == 0
    if new_index % 2 == 1
      @password.rotate!((1 + new_index)/2)
    else
      @password.rotate!(1 + (new_index+password.length)/2)
    end
  end

  def move(indices)
    do_move(indices.reverse)
  end
end

class Parser
  def interpret(string)
    return build_swap_pos(string) if string.start_with?('swap pos')
    return build_swap_letters(string) if string.start_with?('swap let')
    return build_reverse_part(string) if string.start_with?('reverse')
    return build_index_rotate(string) if string.start_with?('rotate bas')
    return build_rotate(string) if string.start_with?('rotate')
    return build_move(string) if string.start_with?('move')
  end

  def build_move(string)
    {
      type: :move,
      payload: find_integers(string)
    }
  end

  def build_rotate(string)
    steps = find_integers(string)[0]
    steps *= -1 if string.include?('right')
    {
      type: :rotate,
      payload: steps
    }
  end

  def build_index_rotate(string)
    {
      type: :index_rotate,
      payload: string.gsub(/\s+/, '')[-1]
    }
  end

  def build_reverse_part(string)
    {
      type: :reverse,
      payload: find_integers(string).sort
    }
  end

  def build_swap_letters(string)
    {
      type: :swap_letters,
      payload: [string.gsub(/\s+/, '')[-1], string[12]]
    }
  end

  def build_swap_pos(string)
    {
      type: :swap_pos,
      payload: find_integers(string)
    }
  end

  def find_integers(string)
    string.scan(/\d+/).map(&:to_i)
  end
end

test_cmds = [
  'swap position 4 with position 0',
  'swap letter d with letter b',
  'reverse positions 0 through 4',
  'rotate left 1 step',
  'move position 1 to position 4',
  'move position 3 to position 0',
  'rotate based on position of letter b',
  'rotate based on position of letter d'
]





def run_cmds(scrambler, cmds)
  cmds.each do |cmd|
    scrambler.exectute(cmd)
  end
  scrambler.output
end


puts '*** Example ***'
s = Scrambler.new('abcde')
puts run_cmds(s, test_cmds)


real_cmds = []
File.open('data.txt').read.each_line do |cmd|
  real_cmds << cmd
end

puts '*** Part 1 ***'
s = Scrambler.new('abcdefgh')
output = run_cmds(s, real_cmds)
puts output
d = Descrambler.new(output)
puts "Descrambled #{run_cmds(d, real_cmds.reverse)}"


puts '*** Part 2 ***'
input = 'fbgdceah'
puts input
d = Descrambler.new(input)
output = run_cmds(d, real_cmds.reverse)
puts output








