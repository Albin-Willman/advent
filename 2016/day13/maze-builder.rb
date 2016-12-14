#!/usr/bin/env ruby

input = 1362

class Maze
  attr_accessor :input, :maze
  def initialize(input)
    @input = input
    @maze = [[cell_value(0, 0)]]
  end

  def add_row
    y = maze.length
    row = []
    maze[0].length.times do |x|
      row << cell_value(x, y)
    end
    maze << row
  end

  def add_column
    x = maze[0].length
    maze.each_with_index do |row, y|
      row << cell_value(x, y)
    end
  end

  def cell_value(x, y)
    return 1 if is_open?(x, y)
    0
  end

  def is_open?(x, y)
    (x*x + 3*x + 2*x*y + y + y*y + input).to_s(2).count('1') % 2 == 0
  end

  def print
    maze.each do |row|
      puts row.map { |e| e == 1 ? '.' : '#' }.join('')
    end
  end
end

class Node
  attr_accessor :neighbors, :distance, :visited
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

class Dijkstras
  attr_accessor :maze, :target_y, :target_x, :nodes, :only_nodes, :current
  def initialize(maze, target_x, target_y)
    @maze, @target_x, @target_y = maze, target_x, target_y
    target_x.times { maze.add_column }
    target_y.times { maze.add_row }
  end

  def run
    setup_nodes
    while current
      current.unvisited_neighbors.each do |neighbor|
        neighbor.set_distance(current.distance + 1)
      end
      current.visited = true
      @current = next_node
    end
  end

  def run_with_target
    run
    throw "no node" unless nodes[target_y][target_x]
    result = nodes[target_y][target_x].distance
    if result == Float::INFINITY
      puts 'No path found, expanding'
      maze.add_column
      maze.add_row
      result = run_with_target
    end
    result
  end

  def next_node
    node = only_nodes.flatten.reject(&:visited).sort { |a,b| a.distance <=> b.distance }.first
    node.distance == Float::INFINITY ? false : node
  end

  def setup_nodes
    @only_nodes = []
    @nodes = []
    maze.maze.each_with_index do |row, i|
      node_row = []
      nodes << node_row
      row.each_with_index do |cell, j|
        if cell == 1
          node_row << new_node(i, j)
          only_nodes << node_row[-1]
        else
          node_row << false
        end
      end
    end
    @current = @nodes[1][1]
    @current.set_distance(0)
  end

  def new_node(i, j)
    node = Node.new
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

m = Maze.new(10)
d = Dijkstras.new(m, 7, 4)
puts d.run_with_target

m = Maze.new(input)
d = Dijkstras.new(m, 31, 39)
puts d.run_with_target

m = Maze.new(input)
d = Dijkstras.new(m, 50, 50)
d.run
puts d.only_nodes.select { |n| n.distance <= 50 }.length



