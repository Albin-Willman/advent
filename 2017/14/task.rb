require "../10/task.rb"

class Defrager
    attr_accessor :input, :grid, :kha, :regions
    def initialize(input)
        @grid = []
        @regions = []
        @input = input
        @kha = KnotHashAdmin.new
    end

    def run
        128.times do |i|
            hex = kha.run("#{input}-#{i}")
            @grid << hex_to_binary(hex)
        end
        map_regions
    end

    def count_ones
        grid.map { |row| row.sum }.sum
    end

    def find_region_index(i,j)
        regions.each_with_index do |region, index|
            return index if region.is_member?(i,j)
        end
        return 'AA'
    end

    def map_regions
        grid.each_with_index do |row, i|
            row.each_with_index do |e, j|
                next unless e == 1
                handle_used_node(i,j)
            end
        end
    end

    def handle_used_node(i,j)
        connected_regions = regions.select do |region|
            region.is_connected?(i,j)
        end
        new_region(i,j) and return if connected_regions.length == 0
        region = connected_regions.first
        region.add_member(i,j)
        return if connected_regions.length == 1
        connected_regions[1..-1].each do |connected_region|
            region.join_region(connected_region)
        end
        clear_empty_regions
    end

    def count_regions
        regions.length
    end

    def new_region(i,j)
        region = Region.new
        region.add_member(i,j)
        @regions << region
    end

    def clear_empty_regions
        regions.reject!(&:is_empty?)
    end

    def hex_to_binary(hex)
        hex.split('').map { |h| "%04b" % h.hex }.join('').split('').map(&:to_i)
    end
end

class Region
    attr_accessor :members
    def initialize
        @members = {}
    end

    def is_connected?(i,j)
        return true if is_member?(i-1,j)
        return true if is_member?(i+1,j)
        return true if is_member?(i,j-1)
        return true if is_member?(i,j+1)
        false
    end

    def add_member(i,j)
        @members[to_key(i,j)] = true
    end

    def is_member?(i,j)
        members[to_key(i,j)]
    end

    def join_region(region)
        @members.merge!(region.members)
        region.reset!
    end

    def reset!
        @members = {}
    end

    def is_empty?
        members.keys.length == 0
    end

    def to_key(i,j)
        "#{i}-#{j}"
    end
end