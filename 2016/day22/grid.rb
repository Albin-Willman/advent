#!/usr/bin/env ruby

Struct.new('Node', :x, :y, :size, :used, :avail)


def construct_node(string)
  data = string.scan(/\d+/).map(&:to_i)
  Struct::Node.new(data[0], data[1], data[2], data[3], data[4],)
end

def viable_pair(a, b)
  return false if a.used == 0
  return false if a.x == b.x && a.y == b.y
  return false if a.used > b.avail
  true
end

nodes = []

File.open('data.txt').read.each_line do |row|
  nodes << construct_node(row)
end
viable_pairs = 0
length = nodes.length

nodes.each_with_index do |a|
  nodes.each do |b|
    viable_pairs += 1 if viable_pair(a, b)
  end
end

puts viable_pairs
test_data = [
  '/dev/grid/node-x0-y0   10T    8T     2T   80%',
  '/dev/grid/node-x0-y1   11T    6T     5T   54%',
  '/dev/grid/node-x0-y2   32T   28T     4T   87%',
  '/dev/grid/node-x1-y0    9T    7T     2T   77%',
  '/dev/grid/node-x1-y1    8T    0T     8T    0%',
  '/dev/grid/node-x1-y2   11T    7T     4T   63%',
  '/dev/grid/node-x2-y0   10T    6T     4T   60%',
  '/dev/grid/node-x2-y1    9T    8T     1T   88%',
  '/dev/grid/node-x2-y2    9T    6T     3T   66%'
]

test_nodes = test_data.map { |e| construct_node(e) }

class Grid
  attr_accessor :nodes, :start, :limit
  def initialize(nodes, limit, start, grid_size)
    @start, @limit = start, limit

    @nodes = Array.new(grid_size[0]).map { |e| Array.new(grid_size[1]) }
    nodes.each do |node|
      @nodes[node.y][node.x] = node
    end
  end

  def print
    nodes.each_with_index do |row_nodes, i|
      row = []
      row_nodes.each_with_index do |node, j|
        if i == 0 && j == 0
          row << '%7.7s' % "(#{node_char(node)})"
        else
          row  << '%7.7s' % "#{node_char(node)} "
        end
      end
      puts row.join('')
    end
  end

  def node_char(node)
    return '#' if node.used > limit
    return '_' if node.used == 0
    return 'D' if node.x == start[0] && node.y == start[1]
    "#{node.used}/#{node.size}"
  end
end
test_nodes = test_data.map { |e| construct_node(e) }
g = Grid.new(test_nodes, 15, [2, 0], [3, 3])
g.print

g = Grid.new(nodes, 120, [34, 0], [25, 35])
g.print
