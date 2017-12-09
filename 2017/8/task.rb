
class Computer
    attr_accessor :registers, :highest_value

    def initialize
        @registers = Hash.new(0)
        @highest_value = -Float::INFINITY
    end

    def run(input)
        input.each do |row|
            Command.new(row, self).execute
            @highest_value = current_high if current_high >= highest_value
        end
        true
    end

    def current_high
        registers.values.max || -Float::INFINITY
    end
end

class Command
    attr_accessor :target, :value, :condition, :type, :compare_value, :compare_target, :computer
    def initialize(row, computer)
        parse_row(row)
        @computer = computer
    end

    def execute
        return unless condition_met?
        computer.registers[target] = computer.registers[target] + value*sign
    end

    def parse_row(row)
        parts = split_row(row)
        @target         = parts[0]
        @type           = parts[1]
        @value          = parts[2].to_i
        @compare_target = parts[4]
        @condition      = parts[5].to_sym
        @compare_value  = parts[6].to_i
    end

    # b inc 5 if a > 1

    def condition_met?
        computer.registers[compare_target].send(condition, compare_value)
    end

    def sign
        return 1 if type == 'inc'
        return -1 if type == 'dec'
    end

    def split_row(row)
        row.gsub(/\s+/m, ' ').split(' ')
    end
end
