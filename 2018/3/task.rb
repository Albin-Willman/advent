class FabricMapper
  attr_accessor :map, :unsulieds
  def initialize(input)
    claims = input.map { |str| Claim.new(str) }

    width_needed = claims.map { |c| c.x + c.width }.max + 2
    height_needed = claims.map { |c| c.y + c.height }.max + 2
    @map = Array.new(width_needed).map { |e| Array.new(height_needed).map { |c| [] }}
    @unsulieds = {}
    claims.each { |c| add(c) }
  end

  def add(claim)
    overlaps = false
    (claim.x..(claim.x + claim.width)).each do |i|
      (claim.y..(claim.y + claim.height)).each do |j|
        if @map[i][j].length > 0
          overlaps = true
          @map[i][j].each do |overlap_id|
            @unsulieds.delete(overlap_id) if @unsulieds[overlap_id]
          end
        end
        @map[i][j] << claim.id
      end
    end
    @unsulieds[claim.id] = claim unless overlaps
  end

  def count_overlaps
    @map.inject(0) { |s, row| s + row.select {|e| e.length > 1}.length }
  end
end

class Claim
  attr_accessor :id, :x, :y, :width, :height
  def initialize(string)
    parts = string.split(' ')
    @id = parts[0].gsub('#', '')
    start = parts[2].split(',').map(&:to_i)
    @x = start[0]
    @y = start[1]
    area = parts[3].split('x').map(&:to_i)
    @width = area[0] - 1
    @height = area[1] - 1
  end
end
