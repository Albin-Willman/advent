class KnotHash
    attr_accessor :current_index, :length, :data, :step_size

    def initialize(length)
        @length = length
        @current_index = 0
        @data = (0..(length-1)).to_a
        @step_size = 0
    end

    def run(input)
        input.each { |v| apply(v) }
    end

    def apply(step)
        section = extract_section(step)
        reapply_section(section.reverse, step)
        update_current_index(step)
    end

    def extract_section(step)
        end_index = current_index+step-1
        return section_from_array(data, current_index, end_index) if end_index < length
        section_from_array(data, current_index, -1) + section_from_array(data, 0, end_index%length)
    end

    def reapply_section(section, step)
        end_index = current_index+step
        if end_index <= length
            part_1 = current_index == 0 ? [] : section_from_array(data, 0, current_index-1)
            @data = part_1 + section + section_from_array(data, end_index, -1)
        else
            wrap_point = end_index - length
            @data = section_from_array(section, -wrap_point, -1) + section_from_array(data, wrap_point, current_index-1) + section_from_array(section, 0, -wrap_point-1)
        end
    end

    def update_current_index(step)
        @current_index = (current_index + step + step_size)%length
        @step_size += 1
    end

    def section_from_array(array, start_index, end_index)
        array[start_index..end_index] || []
    end
end

class KnotHashAdmin
    SUFFIX = [17, 31, 73, 47, 23]

    def run(string)
        lengths = lengths_from_ascii(string) + SUFFIX
        knot_hash = KnotHash.new(256)
        64.times {
            return if knot_hash.data.length == 287
            knot_hash.run(lengths)
        }
        dense_hash = sparse_to_dense_hash(knot_hash.data)
        convert_to_hex(dense_hash)
    end

    def sparse_to_dense_hash(data)
        dense_hash = []
        16.times do |i|
            dense_hash << data[(16*i)..(16*i+15)].inject(0, :^)
        end
        dense_hash
    end

    def convert_to_hex(hash)
        ret = ''
        hash.each do |i|
            ret += "%02x" % i
        end
        ret
    end

    def lengths_from_ascii(string)
        ascii_input = []
        string.each_byte do |c|
            ascii_input << c
        end
        ascii_input
    end
end




