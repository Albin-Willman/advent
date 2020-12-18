class Task
  def self.run(input)
    values = input.map { |str| Expression.new(str.split(' ')).value }
    puts "#{values}"
  end
  def self.run_b(input)
    puts 'Not done yet'
  end

  def self.evaluate(expression)

  end
end

class Expression
  attr_accessor :i, :value, :parts, :operator, :term
  def initialize(input)
    @value = 0
    @i = 0
    @parts = input
    @parts[-1].gsub!(/\s/, '')
    puts "#{@parts}"
    @operator = :+
    compute

  end

  def compute
    loop do
      break if @i >= parts.length

      part = @parts[@i]
      if part.start_with?('(')
        term = Expression.new(find_sub_expression).value
      elsif part == '+' || part == '*'
        @operator = part.to_sym
      else
        @term = part.to_i
      end
      if @term && @operator
        @value = @value.send(@operator, @term)
        @operator = nil
        @term = nil
      end
      @i += 1
    end
  end

  def find_sub_expression
    start = @i
    nesting_level = 0
    loop do
      if parts[i].start_with?('(')
        nesting_level += 1
      elsif parts[i].end_with?(')')
        nesting_level -= 1
      end
    end
    if nesting_level == 0
      @parts[start] = @parts[start][1..-1]
      @parts[@i] = @parts[@i][0..-2]
      return @parts[start..@i]
    end
  end
end


