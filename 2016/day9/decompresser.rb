#!/usr/bin/env ruby

lines = [
  'ADVENT',
  'A(1x5)BC',
  '(3x3)XYZ',
  'A(2x2)BCD(2x2)EFG',
  '(6x1)(1x3)A',
  'X(8x2)(3x3)ABCY'
]

Struct.new('Token', :length, :repeat, :code, :multiplier)

def decompress(line, string = '')
  return string if line.nil?
  start_token = line.index('(')
  return string + line if start_token.nil?
  string += line[0..start_token-1] unless start_token == 0
  end_token = start_token + line[start_token..-1].index(')')
  token = interpret_token(line[start_token+1..end_token-1])
  string += evaluate_token(line[end_token+1..-1], token)
  decompress(line[(end_token+1+token.length)..-1], string)
end

def evaluate_token(string, token)
  string[0..token.length-1]*token.repeat
end

def interpret_token(token)
  values = token.split('x').map(&:to_i)
  Struct::Token.new(values[0], values[1], "(#{token})", 1)
end


File.open('data.txt').read.each_line do |line|
  puts decompress(line).length
end
lines.each do |line|
  decomp = decompress(line)
  puts "#{decomp} #{decomp.length}"
end

class DecodeToken
  attr_accessor :length, :repeat
  def initialize(length, repeat)
    @length, @repeat = length, repeat
  end
end

def split_line(line)
  start_token = line.index('(')
  return [line.length] if start_token.nil?
  end_token = start_token + line[start_token..-1].index(')')
  token = interpret_token(line[start_token+1..end_token-1])
  parts = []
  parts << start_token unless start_token == 0
  parts << interpret_token(line[start_token+1..end_token-1])
  parts + split_line(line[(end_token+1)..-1])
end

def evaluate_length(parts)
  length = 0
  parts.each_with_index do |part, i|
    if part.is_a? Integer
      length += part
      next
    end
    j, token_length, reach = 1, 0, part.length
    while reach > 0

      next_part = parts[i+j]
      if next_part.is_a? Integer
        reach_in_next = [reach, next_part].min
        token_length += reach_in_next*(part.repeat - 1)*part.multiplier
        reach -= next_part
      else
        reach -= next_part.code.length
        next_part.multiplier *= part.repeat
      end
      j += 1
    end

    length += token_length
  end
  length
end

lines2 = [
  '(3x3)XYZ',
  'X(8x2)(3x3)ABCY',
  'XABCABCABCABCABCABCY',
  '(27x12)(20x12)(13x14)(7x10)(1x12)A',
  '(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN'
]

def decompress2_length(line)
  evaluate_length(split_line(line))
end

lines2.each do |line|
  puts decompress2_length(line)
end

File.open('data.txt').read.each_line do |line|
  puts decompress2_length(line)
end


