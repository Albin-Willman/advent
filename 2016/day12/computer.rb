#!/usr/bin/env ruby

class Computer
  attr_accessor :registers, :pointer, :cmds
  def initialize
    @pointer = 0
    @registers = { a: 0, b: 0, c: 1, d: 0 }
  end

  def execute(cmds)
    @cmds = cmds
    cmd = cmds[pointer]
    while cmd
      @pointer += 1
      run(cmd)
      cmd = cmds[pointer]
    end
  end

  def run(cmd)
    send(cmd[:type], cmd[:payload])
  end

  private

  def copy(payload)
    if payload[:value]
      registers[payload[:target]] = payload[:value]
    else
      registers[payload[:target]] = registers[payload[:source]]
    end
  end

  def change(payload)
    registers[payload[:target]] += payload[:value]
  end

  def jump(payload)
    val = payload[:change] || registers[payload[:change_source]]
    val -= 1
    descision = payload[:do_change] || registers[payload[:do_change_source]]

    @pointer += val if descision != 0
  end
end

class Parser
  REGISTERS = 'a'..'d'
  def parse(line)
    return copy_cmd(line) if line.start_with?('cpy')
    return inc_cmd(line) if line.start_with?('inc')
    return dec_cmd(line) if line.start_with?('dec')
    jump_cmd(line)
  end

  def copy_cmd(line)
    values = line[4..-1].split(' ')

    payload = {
      target: values[1].to_sym
    }
    if is_register?(values[0])
      payload[:source] = values[0].to_sym
    else
      payload[:value] = values[0].to_i
    end
    {
      type: :copy,
      payload: payload
    }
  end

  def inc_cmd(line)
    {
      type: :change,
      payload: {
        value: 1,
        target: line[-1].to_sym
      }
    }
  end

  def dec_cmd(line)
    {
      type: :change,
      payload: {
        value: -1,
        target: line[-1].to_sym
      }
    }
  end

  def jump_cmd(line)
    values = line[4..-1].split(' ')
    payload = {}
    if is_register?(values[0])
      payload[:do_change_source] = values[0].to_sym
    else
      payload[:do_change] = values[0].to_i
    end

    if is_register?(values[1])
      payload[:change_source] = values[1].to_sym
    else
      payload[:change] = values[1].to_i
    end
    {
      type: :jump,
      payload: payload
    }

  end

  def is_register?(val)
    REGISTERS.cover?(val)
  end

end

lines = [
  'cpy 41 a',
  'inc a',
  'inc a',
  'dec a',
  'jnz a 2',
  'dec a'
]

parser = Parser.new
# cmds = lines.map { |line| parser.parse(line) }
cmds = []
File.open('data.txt').read.each_line do |line|
  cmds << parser.parse(line.gsub(/\n/, ""))
end
puts cmds

c = Computer.new
c.execute(cmds)

puts c.registers[:a]
