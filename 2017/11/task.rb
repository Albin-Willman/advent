
class HexGrid
    attr_accessor :path, :steps
    def initialize(path)
        @path = path.is_a?(String) ? path.split(',') : path
        @steps = Hash.new(0)
    end

    def effective_distance
        map_path
        remove_loops
        sum_steps
    end

    def map_path
        path.each do |step|
          steps[step] += 1
        end
    end

    def remove_loops
        remove_zig_zag('ne', 'nw', 'n')
        remove_zig_zag('se', 'sw', 's')
        remove_zig_zag('ne', 's', 'se')
        remove_zig_zag('nw', 's', 'sw')

        remove_zig_zag('se', 'n', 'ne')
        remove_zig_zag('sw', 'n', 'nw')

        remove_doubles('ne', 'sw')
        remove_doubles('nw', 'se')
        remove_doubles('n', 's')

    end

    def remove_zig_zag(dir1, dir2, sum_dir)
        doubles = [@steps[dir1], @steps[dir2]].min
        @steps[dir1] = @steps[dir1] - doubles
        @steps[dir2] = @steps[dir2] - doubles
        @steps[sum_dir] = @steps[sum_dir] + doubles
    end

    def remove_doubles(dir1, dir2)
        doubles = [@steps[dir1], @steps[dir2]].min
        @steps[dir1] = @steps[dir1] - doubles
        @steps[dir2] = @steps[dir2] - doubles
    end

    def sum_steps
        count = 0
        steps.each do |dir, val|
            count += val
        end
        count
    end
end
