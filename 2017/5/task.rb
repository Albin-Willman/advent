
class InstructionParser
    attr_accessor :steps, :index, :manipulation_computer

    def initialize(manipulation_computer)
        @manipulation_computer = manipulation_computer
    end
    def run(input)
        steps = 0
        @index = 0
        input = input.clone
        loop do
            step(input)
            steps += 1
            return steps if index >= input.length || index < 0
        end
    end

    def step(input)
        jump = input[index]
        next_index = index + jump
        input[index] = manipulation_computer.new_value(jump)
        @index = next_index
    end
end


class ManipulationComputer
    def new_value(value)
        value + 1
    end
end

class AdvancedManipulationComputer
    def new_value(value)
        return value - 1 if value >= 3
        value + 1
    end
end

