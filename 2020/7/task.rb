class BagCounter
  attr_accessor :bags
  def initialize(info)
    @bags = {}
    info.each do |bag|
      bag.gsub!('bags', '')
      bag.gsub!('bag', '')
      bag.gsub!(/\s/, '')
      bag.gsub!('.', '')
      parts = bag.split('contain')
      @bags[parts[0]] = Bag.new(parts[1])
    end
  end

  def how_many_inside(color)
    @bags[color.gsub(/\s/,'')].bags(@bags).values.sum
  end

  def how_many_can_contain?(color)
    color.gsub!(/\s/,'')
    @bags.values.select { |bag| bag.can_contain?(color, @bags) }.length
    
  end
end

class Bag
  attr_accessor :contents
  def initialize(content)
    @contents = {}
    return if content == 'noother'
    content.split(',').each do |bag|
      @contents[bag.gsub(/\d/, '')] = bag.to_i
    end
  end

  def bags(bags)
    res = Hash.new(0)
    @contents.each do |kv|
      res[kv[0]] = res[kv[0]] + kv[1]
      bags[kv[0]].bags(bags).each do |inner_kv|
        res[inner_kv[0]] = res[inner_kv[0]] + kv[1] * inner_kv[1]
      end
    end
    res
  end

  def can_contain?(color, bags)
    return true if @contents[color]
    @contents.keys.each do |bag|
      return true if bags[bag].can_contain?(color, bags)
    end
    false
  end

  def to_s
    @contents
  end
end