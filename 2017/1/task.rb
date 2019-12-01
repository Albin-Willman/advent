
class InverseCaptch
    attr_accessor :next_index_computer, :data, :value, :length

    def initialize(next_index_computer)
        @next_index_computer = next_index_computer
    end

    def run(input)
        @length = input.length
        @data = input.split('').map(&:to_i)
        @value = 0
        compute
        value
    end

    private

    def compute
        data.each_with_index do |e, i|
            @value += e if e == data[next_index_computer.compute(i, length)]
        end
    end
end


class EasyIndexComputer
    def compute(index, length)
        (index+1)%length
    end
end

class OppositeIndexComputer
    def compute(index, length)
        (index+length/2)%length
    end
end