class MetaFinder
  attr_reader :data

  def initialize(input)
    @data = input
  end

  def run
    node = create_node(0)
    puts "#{node.value1}"
    puts "#{node.value2}"
    node
  end

  def create_node(index)
    node = Node.new

    meta_length = data[index+1]
    @data[index].times do
      node.add_child(create_node(index + node.length))
    end
    meta_data = @data[(index+node.length)..(index+node.length+meta_length-1)]
    node.add_meta(meta_data)
    node
  end
end

class Node
  attr_reader :length, :meta, :children

  def initialize
    @meta, @children, @length = [], [], 2
  end

  def value1
    @value1 ||= @meta.sum + @children.inject(0) { |s, n| s + n.value1 }
  end

  def value2
    @value2 ||= calc_value2
  end

  def calc_value2
    return @meta.sum if @children.length == 0
    val = 0
    @meta.each do |i|
      next unless child = @children[i-1]
      val += child.value2
    end
    val
  end

  def add_child(node)
    @children << node
    @length += node.length
  end

  def add_meta(data)
    @meta = data
    @length += data.length
  end
end
