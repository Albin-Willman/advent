#!/usr/bin/env ruby

test_input = [
  '###########',
  '#0.1.....2#',
  '#.#######.#',
  '#4.......3#',
  '###########'
]

class Node
  attr_accessor :type, :value, :neighbors, :distance, :visited
  def initialize
    @neighbors = []
    @distance = Float::INFINITY
  end

  def unvisited_neighbors
    neighbors.reject(&:visited)
  end

  def set_distance(d)
    return unless d < distance
    @distance = d
  end
end

class Maze
  attr_accessor :data, :values

  def initialize(input)
    @only_nodes = []
    @values = {}
    @data = []
    input.each_with_index do |row_data, i|
      row = []
      row_data.split('').each_with_index do |e, j|
        row << build_node(e, i, j)
      end
      @data << row
    end
  end

  def start_node(value)
    coordinate = values[value]
    data[coordinate[0]][coordinate[1]]
  end

  def build_node(c, i, j)
    node = Node.new
    node.type = node_type(c)
    if node.type == :value
      node.value = c.to_i
      values[node.value] = [i, j]
    end
    node
  end

  def node_type(c)
    return :wall if c == '#'
    return :open if c == '.'
    :value
  end

  def print
    @data.each do |row|
      puts row.map { |n| decode_node(n) }.join('')
    end
  end

  def decode_node(n)
    return n.value if n.type == :value
    return '#' if n.type == :wall
    '.'
  end
end

class Dijkstras
  attr_accessor :maze, :values, :nodes, :only_nodes, :current
  def initialize(maze)
    @maze = maze
  end

  def run(from, target)
    setup_nodes
    @current = maze.start_node(from)
    @current.set_distance(0)
    while current
      return current.distance if  target == current.value
      current.unvisited_neighbors.each do |neighbor|
        neighbor.set_distance(current.distance + 1)
      end
      current.visited = true
      @current = next_node
    end
  end

  def next_node
    only_nodes.reject!(&:visited)
    node = only_nodes.sort { |a,b| a.distance <=> b.distance }.first
    node.distance == Float::INFINITY ? false : node
  end

  def setup_nodes
    @only_nodes = []
    @nodes = []
    maze.data.each_with_index do |row, i|
      node_row = []
      nodes << node_row
      row.each_with_index do |cell, j|
        unless cell.type == :wall
          node_row << connect_node(cell, i, j)
          only_nodes << node_row[-1]
        else
          node_row << false
        end
      end
    end
    @only_nodes.flatten!
  end

  def connect_node(node, i, j)
    if nodes[i-1] && nodes[i-1][j]
      above = nodes[i-1][j]
      node.neighbors << above
      above.neighbors << node
    end
    if nodes[i] && nodes[i][j-1]
      beside = nodes[i][j-1]
      node.neighbors << beside
      beside.neighbors << node
    end
    node
  end
end

class Robot
  attr_accessor :distances, :values
  def initialize(input)
    m = Maze.new(input)
    @values = m.values.keys
    @distances = {}
    compute_distances(input)
  end

  def compute_distances(input)
    pairs = values.permutation(2).to_a.map(&:sort).uniq!
    pairs.each do |pair|
      m = Maze.new(input)
      d = Dijkstras.new(m)
      distances["#{pair[0]}-#{pair[1]}"] = d.run(pair[0], pair[1])
      distances["#{pair[1]}-#{pair[0]}"] = distances["#{pair[0]}-#{pair[1]}"]
    end
  end

  def run(from, should_return)
    shortest_route = []
    shortest = Float::INFINITY
    routes = values.reject { |e| e == from }.permutation
    routes.each do |route|
      distance = 0
      last = from
      route.each do |next_stop|
        distance += distances["#{last}-#{next_stop}"]
        break if distance > shortest
        last = next_stop
      end
      distance += distances["#{last}-#{from}"] if should_return
      if distance < shortest
        shortest_route = [from] + route
        shortest_route << from if should_return
        shortest = distance
      end

    end
    [shortest, shortest_route]
  end
end

r = Robot.new(test_input)
puts "#{r.run(0, false)}"

r = Robot.new(test_input)
puts "#{r.run(0, true)}"

input = []
File.open('data.txt').read.each_line do |line|
  input << line.gsub(/\n/, "")
end

r = Robot.new(input)
puts "#{r.run(0, false)}"

r = Robot.new(input)
puts "#{r.run(0, true)}"
