class SpinLock
    attr_accessor :values, :step_size, :current_index
    def initialize(step_size)
        @step_size = step_size
        @values = [0]
        @current_index = 0
    end

    def take(steps)
        steps.times { step }
    end

    def step
        l = values.length
        @current_index = ((current_index + step_size) % l) + 1
        @values.insert(current_index, l)
    end

    def next_value
        values[(current_index+1)%values.length]
    end
end

class SmartSpinLock
    attr_accessor :value, :step_size, :current_index, :length

    def initialize(step_size)
        @step_size = step_size
        @length = 1
        @current_index = 0
    end

    def take(steps)
        steps.times { step }
    end

    def step
        @current_index = ((current_index + step_size) % length) + 1
        @value = length if @current_index == 1
        @length += 1
    end
end
