class Dance
    attr_accessor :positions, :steps
    def initialize(number_of_dancers)
        @positions = []
        a = 'a'.ord
        number_of_dancers.times do |i|
            positions << (a+i).chr
        end
    end

    def perform(routine)
        @steps = break_down(routine) unless @steps
        steps.each { |step| @positions = step.take(positions) }
    end

    def break_down(routine)
        routine.split(',').map do |step|
            Step.new(step)
        end
    end
end

class Step
    attr_accessor :type, :values
    def initialize(instruction)
        case instruction[0]
        when 's'
            setup_spin(instruction[1..-1])
        when 'x'
            setup_exchange(instruction[1..-1])
        when 'p'
            setup_partner(instruction[1..-1])
        end
    end

    def take(dancers)
        send(type, dancers)
    end

    def setup_spin(data)
        @type = :spin
        @values = data.to_i
    end

    def setup_exchange(data)
        @type = :exchange
        @values = data.split('/').map(&:to_i)
    end

    def setup_partner(data)
        @type = :partner
        @values = data.split('/')
    end


    def spin(dancers)
        dancers.rotate(-values)
    end

    def exchange(dancers)
        swap(dancers, values[0], values[1])
    end

    def partner(dancers)
        swap(dancers, dancers.index(values[0]), dancers.index(values[1]))
    end

    def swap(dancers, i, j)
        tmp = dancers[i]
        dancers[i] = dancers[j]
        dancers[j] = tmp
        dancers
    end
end

class DanceMapper
    def perform(dance, routine)
        start = key(dance)
        1.step do |i|
            dance.perform(routine)
            return i if start == key(dance)
        end
    end

    def key(dance)
        dance.positions.join('')
    end
end
