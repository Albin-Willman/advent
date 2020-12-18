class Task
  def self.run(input)
    c = Computer.new
    c.run(input)
    c.memory.values.sum
  end
  def self.run_b(input)
    c = ComputerB.new
    c.run(input)
    c.memory.values.sum
  end
end

class Computer
  attr_accessor :memory, :program

  def initialize
    @memory = {}
  end

  def run(input)
    input.each { |cmd| execute(cmd) }
  end

  def execute(cmd)
    parts = cmd.split(' = ')
    if(parts[0].start_with?('mem'))
      store(parts[0], parts[1])
    elsif(parts[0].start_with?('mask'))
      new_program(parts[1])
    end
  end

  def store(location, value)
    binary = prepare_binary(value)
    res = []
    @program.each_with_index do |m, i|
      res << ((m == 'X') ? binary[i] : m)
    end
    @memory[location] = res.join('').to_i(2)
  end

  def new_program(mask)
    mask.gsub!(/\s/, '')
    @program = mask.split('')
  end

  def prepare_binary(value)
    value.gsub!(/\s/, '')
    binary = value.to_i.to_s(2).split('')
    Array.new(36 - binary.length, 0) + binary
  end
end

class ComputerB < Computer
  def store(location, value)

    binary = prepare_binary(location[4..-2])
    res = []
    indices = []
    @program.each_with_index do |m, i|
      if m == '1'
        res << '1'
      elsif m == 'X'
        res << 'X'
        indices << i
      elsif m == '0'
        res << binary[i]
      end
    end
    find_addresses(res, indices).each do |address|
      memory[address] = value.to_i
    end
  end

  def find_addresses(bits, floating)
    return [bits.join('').to_i(2)] if floating.length == 0
    res = []
    tmp = bits.clone
    (0..1).each do |bit|
      tmp[floating[0]] = bit
      res += find_addresses(tmp, floating[1..-1])
    end
    res
  end
end