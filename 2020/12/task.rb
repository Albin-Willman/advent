class Task
  def self.run(input)
    Map.new(input).distance
  end
  def self.run_b(input)
    MapB.new(input).distance
  end
end


class Map
  attr_accessor :x, :y, :dir
  def initialize(input)
    @x, @y = 0, 0
    @dir = 'E'
    input.each do |cmd|
      execute!(cmd)
    end
  end

  def distance
    puts "#{x}, #{y}, #{dir}"
    @x.abs + @y.abs
  end

  def execute!(cmd)
    type = cmd[0]
    val = cmd[1..-1].to_i
    case type
    when 'E'
      move(type, val)
    when 'W'
      move(type, val)
    when 'N'
      move(type, val)
    when 'S'
      move(type, val)
    when 'F'
      forward(val)
    when 'L'
      (val/90).times do
        turn(type)
      end
    when 'R'
      (val/90).times do
        turn(type)
      end
    end
  end

  def forward(val)
    move(@dir, val)
  end

  def turn(type)
    if (type == 'L' && @dir == 'E') || (type == 'R' && @dir == 'W')
      @dir = 'N'
    elsif (type == 'L' && @dir == 'W') || (type == 'R' && @dir == 'E')
      @dir = 'S'
    elsif (type == 'R' && @dir == 'N') || (type == 'L' && @dir == 'S')
      @dir = 'E'
    elsif (type == 'R' && @dir == 'S') || (type == 'L' && @dir == 'N')
      @dir = 'W'
    end 
  end

  def move(type, val)
    m = 1
    if type == 'E' || type == 'W'
      m = -1 if type == 'E'
      @x += m*val
    end
    if type == 'S' || type == 'N'
      m = -1 if type == 'S'
      @y += m*val
    end
  end
end


class MapB < Map
  attr_accessor :dx, :dy
  def initialize(input)
    @dx, @dy = -10, 1
    super(input)
  end

  def forward(val)
    @x += val*@dx
    @y += val*@dy
  end

  def turn(type)
    tmp = @dx
    if type == 'L'
      @dx = @dy
      @dy = -tmp
    elsif type == 'R'
      @dx = -@dy
      @dy = tmp
    end
  end

  def move(type, val)
    m = 1
    if type == 'E' || type == 'W'
      m = -1 if type == 'E'
      @dx += m*val
    end
    if type == 'S' || type == 'N'
      m = -1 if type == 'S'
      @dy += m*val
    end
  end
end
