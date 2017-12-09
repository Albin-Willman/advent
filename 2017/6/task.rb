
class Memory
    attr_accessor :banks, :earlier_states, :itteration, :loop_length

    def realocate(banks)
        @banks = banks
        @itteration = 0
        @earlier_states = {}
        loop do
            @itteration += 1
            redistribute highest_index
            return [itteration, loop_length] unless store_state
        end
    end

    private

    def redistribute(index)
        value = banks[index]
        banks[index] = 0
        value.times do |i|
            banks[(index + i + 1)%banks.length] += 1
        end
    end

    def highest_index
        banks.length - 1 - banks.reverse.each_with_index.max[1]
    end

    def store_state
        key = banks.join('-')
        if earlier_states[key]
            @loop_length = itteration - earlier_states[key]
            return false
        end
        earlier_states[key] = itteration
    end
end
