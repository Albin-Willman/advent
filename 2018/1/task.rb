class FrequenzyChanger
  attr_accessor :frequenzies, :value

  def initialize
    @frequenzies = {}
    @value = 0
    @frequenzies[@value] = true
  end


  def run(input)
    input.map(&:to_i).sum
  end

  def run_until_first_repeat(input)
    input.map(&:to_i).each do |i|
      @value += i
      return @value if @frequenzies[@value]
      @frequenzies[@value] = true
    end
    run_until_first_repeat(input)
  end
end
