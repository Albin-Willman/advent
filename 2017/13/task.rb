class Firewall
    attr_accessor :layers, :extra_value

    def initialize(settings)
        @layers = parse(settings)
        @extra_value = 0
    end

    def compute_severity(offset = 0)
        severity = 0
        layers.each do |layer|
            severity += layer_severity(layer[0], layer[1], offset)
        end
        severity
    end

    def find_first_free_offset
        @extra_value = 1
        0.upto(Float::INFINITY) do |i|
            puts "Index: #{i}" if i % 100000 == 0
            severity = compute_severity(i)
            return i if severity == 0
        end
    end

    private

    def layer_severity(depth, range, offset)
        return 0 unless is_caught?(depth + offset, range)
        depth*range + extra_value
    end


    def is_caught?(timeslot, range)
        timeslot%((range-1)*2) == 0
    end

    def parse(settings)
        settings.map { |string| string.gsub(/\s+/m, '').split(':').map(&:to_i) }
    end
end
