class Task
  def self.run(input, n)
    s = Sequence.new(input, n)
    s.run
    s.val.last
  end
  def self.run_b(input)
    puts 'Not done yet'
  end
end


class Sequence
  attr_accessor :val, :last_use, :limit
  def initialize(input, limit)
    @limit = limit
    @val = input.split(',').map(&:to_i)
    @last_use = {}
    @val[0..-2].each_with_index do |v, i|
      @last_use[v] = i + 1
    end
  end

  def run
    loop do
      @val << new_number
      break if @val.length >= @limit      
    end
  end

  def new_number
    last_index = @last_use[@val[-1]]
    @last_use[@val[-1]] = @val.length
    return 0 if last_index == nil
    @val.length - last_index
  end
end