#!/usr/bin/env ruby

class Screen
  attr_accessor :matrix
  def initialize(width, height)
    @matrix = []
    height.times do
      row = []
      width.times do
        row << 0
      end
      matrix << row
    end
  end

  def execute(instruction)
    return unless instruction.command
    send(instruction.command, instruction.x, instruction.y)
  end

  def print_screen
    matrix.each do |column|
      row = ''
      column.each do |e|
        row += e == 0 ? ' ' : '#'
      end
      puts row
    end
    puts ''
  end

  def rect(width, height)
    width.times do |i|
      height.times do |j|
        matrix[j][i] = (matrix[j][i] + 1) % 2
      end
    end
  end

  def rotate_row(row, steps)
    matrix[row].rotate!(-steps)
  end

  def rotate_column(column_index, steps)
    column = matrix.map { |row| row[column_index] }
    column.rotate!(-steps)
    column.each_with_index do |v, i|
      matrix[i][column_index] = v
    end
  end

  def count_leds
    matrix.map { |row| row.inject(0, :+)}.inject(0, :+)
  end
end

Struct.new('Instruction', :command, :x, :y)

def interpret_line(line)
  return rect_instruction(line) if line.start_with?('rect')
  return rotate_row_instruction(line) if line.start_with?('rotate row')
  return rotate_column_instruction(line) if line.start_with?('rotate column')

  Struct::Instruction.new
end

def rotate_row_instruction(line)
  vals = rotate_vals(line)
  instruction = Struct::Instruction.new(:rotate_row, vals[0], vals[1])
end

def rotate_column_instruction(line)
  vals = rotate_vals(line)
  instruction = Struct::Instruction.new(:rotate_column, vals[0], vals[1])
end

def rotate_vals(line)
  line.split('=')[1].split(' by ').map(&:to_i)
end

def rect_instruction(line)
  vals = line[5..-1].split('x').map(&:to_i)
  instruction = Struct::Instruction.new(:rect, vals[0], vals[1])
end

s = Screen.new(50, 6)

File.open('data.txt').read.each_line do |line|
  s.execute(interpret_line(line))
  s.print_screen
end

puts s.count_leds
