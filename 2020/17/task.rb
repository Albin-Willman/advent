class Task
  def self.run(input)
    g = Grid.new(input, 3)
    g.run(6)
    g.active_cubes.values.length
  end
  def self.run_b(input)
    g = Grid.new(input, 4)
    g.run(6)
    g.active_cubes.values.length
  end
end

class Grid
  attr_accessor :active_cubes, :dimensions

  def initialize(input, dimensions)
    @dimensions = dimensions
    @active_cubes = {}
    zeroes = Array.new(dimensions - 2, 0)
    input.each_with_index do |row, y|
      row.split('').each_with_index do |cube, x|
        next unless cube == '#'
        coordinate = [x, y] + zeroes
        @active_cubes[coordinate.join(':')] = coordinate
      end
    end
  end

  def run(n)
    n.times { itterate }
  end

  def itterate
    next_itteration = {}
    checked_coordinates = {}
    @active_cubes.values.each do |cube|
      get_closeby_coordinates(cube, 0).each do |coordinate|
        key = coordinate.join(':')
        next if checked_coordinates[key]
        checked_coordinates[key] = true
        next_itteration[key] = coordinate if is_active_next?(coordinate)
      end
    end
    @active_cubes = next_itteration
  end

  def get_closeby_coordinates(coordinate, dim)
    return [coordinate] if dim == @dimensions
    list = get_closeby_coordinates(coordinate, dim + 1)
    res = []
    val = list.map do |c| 
      [-1, 0, 1].each do |delta|
        tmp = c.clone
        tmp[dim] = c[dim] + delta
        res << tmp
      end
    end
    res
    
  end

  def is_active_next?(c)
    active = @active_cubes[c.join(':')]
    active_neibours = active ? -1 : 0
    get_closeby_coordinates(c, 0).each do |n|
      key = n.join(':')
      active_neibours += 1 if @active_cubes[key]
      return false if active_neibours >= 4
    end
    return true if active_neibours == 3
    active_neibours == 2 && active
  end
end 