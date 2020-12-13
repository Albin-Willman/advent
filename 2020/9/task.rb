class Task
  def self.run(input, number_of_elements)
    input.map!(&:to_i)
    (number_of_elements..(input.length-1)).each do |i|
      found = false
      input[i-number_of_elements..(i-1)].permutation(2).each do |parts|
        if parts.sum == input[i]
          found = true
          break
        end
      end
      return input[i] unless found
    end
    'Not found'
  end

  def self.run_b(input, number_of_elements)
    value = run(input, number_of_elements)
    input.length.times do |i|
      j = 1
      while (j + i) < input.length
        a = input[i..(i+j)]
        sum = a.sum
        if sum > value
          break
        elsif sum == value
          return a.max + a.min
        end
        j += 1
      end
    end
  end
end
