
class Duet
    attr_accessor :recoveries, :last_tone, :registers, :current_index, :commands

    def initialize
        @recoveries = 0
        @registers = Hash.new(0)
    end

    def play(commands)
        @current_index = 0
        @commands = commands.map { |cmd| Instruction.new(cmd) }
        while (current_index >= 0 && current_index < @commands.length)
            @commands[current_index].run(self)
            @current_index += 1
            return recoveries if recoveries && recoveries != 0
        end
    end

    def sound(freq)
        @last_tone = freq
    end

end


class Instruction
    attr_accessor :type, :values

    def initialize(command)
        setup(parse(command))
    end

    def parse(command)
        command.split(' ')
    end

    def setup(parts)
        @type = parts[0].to_sym
        setup_values(parts[1..-1])
    end

    def setup_values(parts)
        @values = parts.map { |p| clean(p) }
    end

    def clean(p)
        return p.to_i if is_i?(p)
        p.to_sym
    end

    def get_value(i, duet)
        part = values[i]
        return part if part.is_a?(Integer)
        duet.registers[part]
    end

    def is_i?(i)
       !!(i =~ /\A[-+]?[0-9]+\z/)
    end

    def run(duet)
        send(type, duet)
    end


    def snd(duet)
        duet.sound(get_value(0, duet))
    end

    def set(duet)
        duet.registers[values[0]] = get_value(1, duet)
    end

    def add(duet)
        duet.registers[values[0]] += get_value(1, duet)
    end

    def mul(duet)
        duet.registers[values[0]] *= get_value(1, duet)
    end

    def mod(duet)
        duet.registers[values[0]] = duet.registers[values[0]] % get_value(1, duet)
    end

    def rcv(duet)
        duet.recoveries = duet.last_tone if duet.last_tone != 0
    end

    def jgz(duet)
        jump = get_value(1, duet)
        jump = jump - 1 if jump < 0
        duet.current_index += jump if duet.registers[values[0]] > 0
    end
end


 # X plays a sound with a frequency equal to the value of X.
 # X Y sets register X to the value of Y.
 # X Y increases register X by the value of Y.
 # X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
 # X Y sets register X to the remainder of dividing the value contained in register X by the value of Y (that is, it sets X to the result of X modulo Y).
 # X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
 # X Y
