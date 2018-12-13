class StarMap
  attr_accessor :stars, :width, :height
  def initialize(input, width, height)
    @width = width
    @height = height
    @stars = input.map { |str| Star.new(str) }
  end

  def step
    @stars.each(&:step)
    print
  end

  def fast_forward(i)
    @stars.each { |star| star.fast_forward(i) }
    print
  end

  def print
    puts 'Print'
    grid = Array.new(@height).map { |_| Array.new(@width, '.')}
    x_range  = (0..(@width-1))
    y_range  = (0..(@height-1))
    @stars.each do |star|
      next unless x_range.include?(star.x) && y_range.include?(star.y)
      grid[star.y][star.x] = '#'
    end
    grid.each { |row| puts row.join('') }
  end

  def star_at?(x, y)
    @stars.find { |star| (star.x == x && star.y == y) }
  end

end

class Star
  attr_accessor :x, :y, :dx, :dy
  def initialize(str)
    @x, @y, @dx, @dy = str.gsub('position=<', '').gsub('> velocity=<', ',').gsub('>', '').gsub(' ', '').split(',').map(&:to_i)
  end

  def step
    fast_forward(1)
  end

  def fast_forward(i)
    @x += i * @dx
    @y += i * @dy
  end
end
