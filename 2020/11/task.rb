class Task
  def self.run(input)
    Map.new(input, false).find_stable_state
  end
  def self.run_b(input)
    Map.new(input, true).find_stable_state
  end
end


class Map
  attr_accessor :seats

  def initialize(input, part_b = false)
    seat_hash = {}
    input.each_with_index do |row, i|
      row.split('').each_with_index do |s, j|
        seat_hash["#{i}:#{j}"] = Seat.new(part_b ? 5 : 4) if s == 'L'
      end
    end
    populate_neighbours(seat_hash, input.length, input.first.length, part_b)
    @seats = seat_hash.values
  end

  def populate_neighbours(seat_hash, x, y, part_b)
    x.times do |i|
      y.times do |j|
        find_neighbours(seat_hash, i, j, x, y, part_b)
      end
    end
  end

  def find_neighbours(seat_hash, i, j, x, y,part_b)
    seat = seat_hash["#{i}:#{j}"]
    return unless seat
    (-1..1).each do |n|
      (-1..1).each do |m|
        next if (n == 0 && m == 0)
        k = 1
        loop do
          if seat_hash["#{i+(n*k)}:#{j+(m*k)}"]
            seat.neighbours << seat_hash["#{i+(n*k)}:#{j+(m*k)}"]
            break
          end
          break if !part_b || !(0..(x-1)).include?(i+(n*k)) || !(0..(y-1)).include?(j+(m*k))
          k += 1
        end
      end
    end
  end

  def find_stable_state
    loop do
      changes = @seats.select(&:itterate)
      return @seats.select(&:occupied).length if changes.length == 0
      @seats.each(&:execute!)
    end
  end
end

class Seat
  attr_accessor :occupied, :neighbours, :next_state, :limit

  def initialize(limit)
    @neighbours = []
    @occupied = false
    @limit = limit
  end

  def itterate
    count = @neighbours.select(&:occupied).length
    if @occupied && count >= limit
      @next_state = false
      return true
    elsif !occupied && count == 0
      @next_state = true
      return true
    end
    false
  end

  def execute!
    @occupied = @next_state
  end
end