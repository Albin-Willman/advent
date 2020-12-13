class Task
  def self.run(input)
    input.map!(&:to_i)
    input += [0, input.max+3]
    diffs = input.sort.each_cons(2).collect { |a,b| b-a }
    counts = diffs.inject(Hash.new(0)) { |total, e| total[e] += 1 ; total }
    counts.values.inject(&:*)
  end
  def run_b(input)
    input.map!(&:to_i)
    input += [0, input.max+3]
    @cache = {}
    possibilities(input.sort)
  end

  def possibilities(input)
    return @cache[input[0]] if @cache[input[0]]
    @cache[input[0]] = do_count_possibilities(input)
    @cache[input[0]]
  end

  def do_count_possibilities(input)
    return 1 if input.length == 1
    sum = 0
    (1..3).each do |i|
      sum += possibilities(input[i..-1]) if input[i] && input[i] <= input[0] + 3
    end
    sum
  end
end
