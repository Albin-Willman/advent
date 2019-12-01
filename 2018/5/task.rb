class Reductor

  def run(str)
    reduce(str.split(''))
  end

  def reduce(arr)
    indices = []
    (0..(arr.length-2)).each do |i|
      next if indices.include?(i)
      if does_react?(arr[i], arr[i+1])
        indices << i
        indices << i + 1
      end
    end
    return arr.join('') if indices.length == 0
    indices.sort.reverse.each { |i| arr.delete_at(i) }
    reduce(arr)
  end

  def does_react?(e1, e2)
    return false if e1 == e2
    return e2.upcase == e1 if /[[:upper:]]/.match(e1)
    return e2.downcase == e1 if /[[:lower:]]/.match(e1)
  end
end

class PolymerImprover
  attr_accessor :input, :elements, :reductor
  def initialize(input)
    @input = input
    @elements = {}
    @reductor = Reductor.new
  end

  def run
    ('a'..'z').each do |l|
      test_input = @input.gsub(l, '').gsub(l.upcase, '')
      @elements[l] = @reductor.run(@input.gsub(l, '').gsub(l.upcase, '')).length
      puts "#{l} -> #{@elements[l]}"
    end
    @elements.values.min
  end
end
