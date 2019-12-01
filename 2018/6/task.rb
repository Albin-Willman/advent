

class AreaMapper
  attr_accessor :areas, :grid, :corners

  def initialize(input)
    @areas = input.map { |str| Area.new(str, 0) }
    @areas.each_with_index { |a, i| a.id = i + 1 }
    determine_corners
    create_grid
  end

  def run
    @grid.each_with_index do |row, i|
      row.each_with_index do |e, j|
        if area = find_closest_area(i,j)
          @grid[i][j] = area.id
          area.area += 1
        end
      end
    end
    puts areas.reject { |a| is_infinite?(a) }.sort_by { |a| a.area }.map { |a| "#{a.id}: (#{a.x}, #{a.y}) #{a.area}" }
  end

  def is_infinite?(area)
    border.include?(area.id)
  end

  def find_closest_area(i,j)
    sorted = areas.sort_by {|a| a.distance_to(i,j) }
    return sorted[0] unless sorted[0].distance_to(i,j) == sorted[1].distance_to(i,j)
    nil
  end

  def border
    @border_areas ||= (@grid[0] + @grid[-1] + @grid.map(&:first) + @grid.map(&:last)).uniq
    @border_areas
  end

  def create_grid
    @grid = (0..(@corners[0][1]+1)).map { |_| Array.new(@corners[1][1]+1, '.') }
  end

  def determine_corners
    xs = @areas.map(&:x)
    ys = @areas.map(&:y)
    @corners = [[xs.min, xs.max], [ys.min, ys.max]]
  end
end

class Area
  attr_accessor :x, :y, :area, :id
  def initialize(center, id)
    @id = id
    @x, @y = center.split(',').map(&:to_i).reverse
    @area = 0
  end

  def distance_to(point_x, point_y)
    (@x - point_x).abs + (@y - point_y).abs
  end
end

class DangerAreaMapper < AreaMapper
  def run(limit)
    safe_zones = 0
    @grid.each_with_index do |row, i|
      row.each_with_index do |e, j|
        @grid[i][j] = sum_distances(i,j)
        safe_zones += 1 if @grid[i][j] < limit
      end
    end
    safe_zones
  end

  def sum_distances(i,j)
    areas.inject(0) { |s, a| s + a.distance_to(i,j) }
  end
end
