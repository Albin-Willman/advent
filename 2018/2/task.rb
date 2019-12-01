class CrateChecker
  attr_accessor :twos, :threes
  def initialize
    @twos = 0
    @threes = 0
  end

  def compute_checksum(input)
    input.each { |id| evalute_id(id) }
    @twos * @threes
  end

  def evalute_id(id)
    values = id.split('').inject(Hash.new(0)) { |h, l|
      h[l] += 1
      h
    }.values
    @twos += 1 if values.include?(2)
    @threes += 1 if values.include?(3)
  end
end

class CrateFinder

  def find_correct(input)
    input.each_with_index do |id, i|
      wrong_index = check_id(id, input, i)
      if wrong_index
        id.slice!(wrong_index)
        return id
      end
    end
  end

  def check_id(id, input, i)
    i.times do |j|
      wrong_index = compare_ids(id, input[j])
      return wrong_index if wrong_index
    end
    false
  end

  def compare_ids(a, b)
    error = nil

    a.split('').each_with_index do |l, i|
      if l != b[i]
        return false unless error.nil?
        error = i
      end
    end
    error
  end
end
