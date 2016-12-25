#!/usr/bin/env ruby

require '../day12/computer.rb'

class SearchComputer < Computer
  def execute(input, target)
    @cmds ||= input
    cmd = cmds[pointer]
    while cmd
      run(cmd)
      @pointer += 1
      cmd = cmds[pointer]
      if output.length > 0 && output[-1] != target[output.length - 1]
        return false
      elsif output.length == target.length
        return true
      end
    end
  end
end

parser = Parser.new
cmds = []
File.open('data.txt').read.each_line do |line|
  cmds << parser.parse(line.gsub(/\n/, ""))
end
found = false
i = 0
until found
  c = SearchComputer.new
  c.registers[:a] = i
  found = c.execute(cmds, [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]*3)

  i += 1
end

puts i
