class CartMap
  attr_accessor :grid, :carts

  CART_CHARS = ['^', '<', 'v', '>']
  TURN_CHARS = ['\\', '/']

  def initialize(input)
    @grid, @carts = {}, []
    input.each_with_index do |row, y|
      row.split('').each_with_index do |e, x|
        @carts << Cart.new(e, x, y) if CART_CHARS.include?(e)
        @grid["#{x},#{y}"] = Corner.new(e) if TURN_CHARS.include?(e)
        @grid["#{x},#{y}"] = Intersection.new if e == '+'
      end
    end
  end

  def find_first_collision
    @res = false
    until @res
      @res = step
    end
    @res
  end

  def find_last_cart
    until @carts.length == 1
      crashes = find_first_collision
      crashes.each do |pos|
        @carts = @carts.delete_if { |c|
          c.to_s == pos
        }
      end
    end
    @carts.first.to_s
  end

  def step
    sort_carts
    crashes = []
    @carts.each do |c|
      next if crashes.include?(c.to_s)
      c.move
      pos = c.to_s
      if collision?(pos)
        crashes << pos
      else
        @grid[pos].turn_cart(c) if @grid[pos]
      end
    end
    return false if crashes.length == 0
    crashes
  end

  def collision?(pos)
    @carts.select {|c| c.to_s == pos }.length > 1
  end

  def sort_carts
    @carts.sort! { |a, b| [a.y, a.x] <=> [b.y, b.x] }
  end
end

class Cart
  attr_accessor :x, :y, :direction, :intersections

  LEFT_MAP = {
    '>' => '^',
    '^' => '<',
    '<' => 'v',
    'v' => '>'
  }

  RIGHT_MAP = {
    '>' => 'v',
    '^' => '>',
    '<' => '^',
    'v' => '<'
  }

  def initialize(str, x, y)
    @x = x
    @y = y
    @direction = str
    @intersections = 0
  end

  def to_s
    "#{@x},#{@y}"
  end

  def intersection
    case (@intersections % 3)
    when 0
      turn_left
    when 2
      turn_right
    end
    @intersections += 1
  end

  def turn_left
    @direction = LEFT_MAP[@direction]
  end

  def turn_right
    @direction = RIGHT_MAP[@direction]
  end

  def move
    case @direction
    when '>'
      @x += 1
    when 'v'
      @y += 1
    when '^'
      @y -= 1
    when '<'
      @x -= 1
    end
  end
end

class Corner
  attr_accessor :turn
  def initialize(str)
    @turn = {}
    case str
    when '/'
      @turn['^'] = '>'
      @turn['<'] = 'v'
      @turn['>'] = '^'
      @turn['v'] = '<'
    when '\\'
      @turn['^'] = '<'
      @turn['<'] = '^'
      @turn['>'] = 'v'
      @turn['v'] = '>'
    end
  end

  def turn_cart(c)
    c.direction = @turn[c.direction]
  end
end

class Intersection

  def turn_cart(c)
    c.intersection
  end
end
