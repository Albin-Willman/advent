class Task
  def self.run(input)
    at = input[0].to_i
    buses = input[1].split(',').reject { |e| e == 'x' }.map(&:to_i)
    min_time = buses.max
    val = 0
    buses.each do |bus|
      wait = bus - (at % bus)
      if wait < min_time
        min_time = wait
        val = bus * wait
      end
    end 
    val
  end
  def self.run_b(input)
    buses = []
    input[1].split(',').each_with_index do |bus, i|
      buses << {id: bus.to_i, delay: i} unless bus == 'x'
    end
    candidate = buses[0][:id]
    increase = 1
    

    loop do 
      valid = true
      buses.each do |bus|
        if (candidate + bus[:delay]) % bus[:id] == 0
          increase = increase.lcm(bus[:id])
        else
          valid = false
        end
      end
      
      return candidate if valid
      candidate += increase
    end
  end
end
