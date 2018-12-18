class Pots
  attr_accessor :state, :instructions
  def initialize(state, instructions, generations)
    @generations = generations
    @padding = Array.new(generations + 2, '.').join('')
    @state = "#{@padding}#{state}#{@padding}"
    @instructions = {}
    instructions.each do |str|
      instruction = interpret(str)
      @instructions[instruction[0]] = instruction[1]
    end
    print(0)
  end

  def interpret(str)
    [str[0..4], str[-1]]
  end

  def run
    (1..@generations).each do |step|
      new_state = '..'
      (0..(@state.length-5)).each do |i|
        new_state += (instructions[@state[i..(i+4)]] || '.')
      end
      new_state += '..'
      @state = new_state
      print(step)
    end
  end

  def value
    keys.sum
  end

  def keys
    indices = []
    @state.split('').each_with_index do |l, i|
      if l == '#'
        indices << (i-@padding.length)
      end
    end
    indices
  end

  def print(i)
    puts "#{i} - #{value} - #{keys}"
  end
end