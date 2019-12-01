
class SpiralDistance

    def run(index)
        return 0 if index == 1
        layer = find_layer(index)

        index_on_layer = find_index_on_layer(index, layer)
        side_length = find_side_length(layer)
        index_on_side = index_on_layer % side_length + 1
        layer + (index_on_side - layer).abs
    end

    private

    def find_side_length(layer)
        (layer*2)
    end

    def find_index_on_layer(index, layer)
        index - odd_square(layer) - 1
    end

    def find_layer(index)
        1.step do |i|
            return (i-1) if odd_square(i) >= index
        end
    end

    def odd_square(i)
        (i*2 - 1)**2
    end
end

class SpiralWriter
    attr_accessor :data, :x, :y, :index
    def initialize
        @data = {"0-0" => 1}
        @x = 1
        @y = 0
        @index = 1
        @index_on_side = 1
    end

    def run(limit)
        loop do
            value = step
            return value if value > limit
        end
    end

    def step
        value = calculate_value
        data["#{x}-#{y}"] = calculate_value
        move
        value
    end

    def move
        @y += 1 and return if should_move_up?
        @x += 1 and return if should_move_right?
        @y -= 1 and return if should_move_down?
        @x -= 1 and return if should_move_left?
    end

    def calculate_value
        find_neighbors.inject(0, :+)
    end

    def find_neighbors
        neighbors = []
        [-1, 0, 1].each do |i|
            [-1, 0, 1].each do |j|
                next if i == 0 && j == 0
                neighbors << data["#{x+i}-#{y+j}"]
            end
        end
        neighbors.reject{ |e| e.nil? }
    end

    private

    def should_move_up?
        return false if data["#{x}-#{y+1}"]
        return true if data["#{x-1}-#{y}"]
    end

    def should_move_right?
        return false if data["#{x+1}-#{y}"]
        return true if data["#{x}-#{y+1}"]
    end

    def should_move_left?
        return false if data["#{x-1}-#{y}"]
        return true if data["#{x}-#{y-1}"]
    end

    def should_move_down?
        return false if data["#{x}-#{y-1}"]
        return true if data["#{x+1}-#{y}"]
    end
end
