#!/usr/bin/env ruby

class Robot
  attr_accessor :chips, :coordinator, :target_high, :target_low, :id
  def initialize(coordinator, id)
    @coordinator, @chips, @id = coordinator, [], id
  end

  def recieve(chip)
    chips << chip
    make_comparisson
  end

  def make_comparisson
    return unless chips.length == 2 && target_high && target_low
    puts "#{id} Comparing the chips" if chips.max == 61 && chips.min == 17
    coordinator.distribute(target_high, chips.max)
    coordinator.distribute(target_low, chips.min)
    chips = []
    return true
  end

  def set(instruction)
    @target_high = instruction[:target_high]
    @target_low = instruction[:target_low]
    make_comparisson
  end
end

class Output
  attr_accessor :bin
  def initialize
    @bin = []
  end

  def recieve(chip)
    bin << chip
    false
  end
end

class Coordinator
  attr_accessor :outputs, :robots
  def initialize
    @outputs, @robots = {}, {}
  end

  def exectute(instruction)
    action = parse(instruction)
    robot(action[:robot_id]).send(action[:action], action[:payload])
  end

  def parse(instruction)
    return parse_input(instruction) if instruction.start_with?('value')
    parse_robot_setting(instruction)
  end

  def parse_robot_setting(instruction)
    values = instruction.scan(/\d+/).map(&:to_i)
    low_target = instruction.include?('w to b') ? :robot : :output
    high_target = instruction.include?('h to b') ? :robot : :output
    {
      action: :set,
      robot_id: values[0],
      payload: {
        target_low: {
          type: low_target,
          id: values[1]
        },
        target_high: {
          type: high_target,
          id: values[2]
        }
      }
    }
  end

  def parse_input(instruction)
    values = instruction.scan(/\d+/).map(&:to_i)
    {
      action: :recieve,
      payload: values[0],
      robot_id: values[1]
    }
  end

  def distribute(target, chip)
    send(target[:type], target[:id]).recieve(chip)
  end

  def robot(id)
    robots[id] ||= Robot.new(self, id)
  end

  def output(id)
    outputs[id] ||= Output.new
  end
end

lines = [
  'value 5 goes to bot 2',
  'bot 2 gives low to bot 1 and high to bot 0',
  'value 3 goes to bot 1',
  'bot 1 gives low to output 1 and high to bot 0',
  'bot 0 gives low to output 2 and high to output 0',
  'value 2 goes to bot 2'
]

coordinator = Coordinator.new
# lines.each do |line|
File.open('data.txt').read.each_line do |line|
  coordinator.exectute(line)
end

result = 1
3.times do |i|
  result *= coordinator.output(i).bin[0]
end

puts result
