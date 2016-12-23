#!/usr/bin/env ruby

require '../day12/computer.rb'

class AdvancedComputer < Computer
  attr_accessor :parser
  def add_cmd(line)
    @cmds ||= []
    @cmds << parser.parse(line)
  end

  def toggle(register)
    index = pointer + registers[register]
    cmds[index] = new_cmd(cmds[index])
  end

  def new_cmd(cmd)
    return unless cmd
    case cmd[:type]
    when :change
      if cmd[:cmd].start_with?('inc')
        return parser.parse(cmd[:cmd].gsub('inc', 'dec'))
      else
        return parser.parse(cmd[:cmd].gsub('dec', 'inc'))
      end
    when :jump
      return parser.parse(cmd[:cmd].gsub('jnz', 'cpy'))
    when :copy
      return parser.parse(cmd[:cmd].gsub('cpy', 'jnz'))
    when :toggle
      return parser.parse(cmd[:cmd].gsub('tgl', 'inc'))
    end
  end
end

class AdvancedParser < Parser
  def parse(line)
    return toggle_cmd(line) if line.start_with?('tgl')
    res = do_parse(line)
    res[:cmd] = line
    res
  end

  def toggle_cmd(string)
    {
      type: :toggle,
      payload: string[4].to_sym,
      cmd: string
    }
  end
end


lines = [
  'cpy 2 a',
  'tgl a',
  'tgl a',
  'tgl a',
  'cpy 1 a',
  'dec a',
  'dec a'
]

parser = AdvancedParser.new
# cmds = []
# File.open('data.txt').read.each_line do |line|
#   cmds << parser.parse(line.gsub(/\n/, ""))
# end
# puts cmds

c = AdvancedComputer.new
c.parser = parser
lines.each { |line| c.add_cmd(line) }
c.execute(nil)

puts c.registers[:a]

c = AdvancedComputer.new
c.parser = parser
File.open('data.txt').read.each_line do |line|
  c.add_cmd(line.gsub(/\n/, ""))
end
c.registers[:a] = 7
c.execute(nil)

puts c.registers[:a]

c = AdvancedComputer.new
c.parser = parser
File.open('data.txt').read.each_line do |line|
  c.add_cmd(line.gsub(/\n/, ""))
end

c.registers[:a] = 12
c.execute(nil)

puts c.registers[:a]

