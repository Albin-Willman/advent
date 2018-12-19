class Cooker
  attr_accessor :recipies, :elf1, :elf2

  def initialize(recipies)
    @recipies = recipies
    @elf1 = 0
    @elf2 = 1
  end

  def run(breakpoint)
    until @recipies.length > (breakpoint + 10)
      step
    end
    @recipies[(breakpoint)..(breakpoint+9)].map(&:to_s).join('')
  end

  def find(needle)
    i, step_size = 0, 2
    loop do
      step_size.times do
        step
      end
      res = @recipies.join('').index(needle)
      return res if res
      i += step_size
      step_size *= 2
      puts "#{i} Nope"
    end
  end

  def step
    val = (@recipies[@elf1] + @recipies[@elf2])
    if val >= 10
      @recipies << val/10
      @recipies << val%10
    else
      @recipies << val
    end
    @elf1 = (@elf1 + 1 + @recipies[@elf1]) % @recipies.length
    @elf2 = (@elf2 + 1 + @recipies[@elf2]) % @recipies.length
  end
end
