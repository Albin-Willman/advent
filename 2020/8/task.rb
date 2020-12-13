class Computer
  attr_accessor :value, :current, :previous, :terminated

  def initialize
    @value = 0
    @current = 0
    @previous = {}
    @terminated = false
  end

  def run(instructions)
    loop do
      return @value if @previous[@current]
      if @current >= instructions.length
        @terminated = true
        return @value
      end

      execute(instructions[@current])
    end
  end

  def execute(instruction)
    parts = instruction.split(' ')
    @previous[@current] = true
    case parts[0]
    when 'acc'
      @value += parts[1].to_i
      @current += 1
    when 'jmp'
      @current += parts[1].to_i
    when 'nop'
      @current += 1
    end
  end
end

class ComputerFixer

  def self.find_fix(input)
    input.each_with_index do |instruction, i|
      if (instruction.start_with?('jmp') || instruction.start_with?('nop'))
        test_set = input.clone
        if (instruction.start_with?('jmp'))
          test_set[i] = test_set[i].gsub('jmp', 'nop')
        elsif (instruction.start_with?('nop'))
          test_set[i] = test_set[i].gsub('nop', 'jmp')
        end
        c = Computer.new
        value = c.run(test_set)
        if c.terminated
          puts "Fixed line: #{i} #{input[i]}"
          return value
        end
      end
    end

  end

end
