class FuelGrid
  GRID_SIZE = 300
  attr_accessor :serial_number, :grid, :best_value, :square_coordinates

  def initialize(serial_number)
    @serial_number = serial_number
    @grid = []
    (1..GRID_SIZE).each do |x|
      rack = []
      (1..GRID_SIZE).each do |y|
        rack << FuelCell.new(x,y)
      end
      @grid << rack
    end
  end

  def find_best_cell(square_sizes)
    @best_value = 0
    @square_coordinates = ''
    square_sizes.each do |square_size|
      (0..(GRID_SIZE-square_size)).each do |x|
        (0..(GRID_SIZE-square_size)).each do |y|
          value = evaluate_square(x,y,square_size)
          @square_coordinates, @best_value = "#{x+1},#{y+1},#{square_size}", value if value > @best_value
        end
      end
      puts "#{square_size} - #{@square_coordinates}"
    end
    @square_coordinates
  end

  def evaluate_square(x,y,square_size)
    value = 0
    (0..(square_size-1)).each do |dx|
      (0..(square_size-1)).each do |dy|
        value += @grid[x+dx][y+dy].value(@serial_number)
      end
    end
    value
  end
end

class FuelCell
  attr_accessor :x, :x, :value
  def initialize(x, y)
    @x = x
    @y = y
  end

  def value(serial_number)
    @value ||= calc_value(serial_number)
  end

  def calc_value(serial_number)
    rack_id = @x + 10
    ((rack_id * @y + serial_number) * rack_id).to_s[-3].to_i - 5
  end
end
