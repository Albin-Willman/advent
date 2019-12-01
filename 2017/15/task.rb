
class Generator
    attr_accessor :p, :d, :value, :rule
    def initialize(p, d, value, rule = false)
        @p = p
        @d = d
        @value = value
        @rule = rule
    end

    def compute
        @value = (value * p) % d
        return value if !rule || value % rule == 0
        compute
    end
end


class Judge
    attr_accessor :a, :b, :pairs

    def initialize(a, b)
        @a = a
        @b = b
        @pairs = 0
    end

    def run(itterations)
        itterations.times do |i|
            puts "Itteration #{i} #{pairs}" if (i % 1_000_000) == 0
            @pairs += 1 if equal?(a.compute, b.compute)
        end
    end

    def equal?(value_a, value_b)
        relevant_binary(value_a) == relevant_binary(value_b)
    end

    def relevant_binary(i)
        to_binary(i)[-16..-1]
    end

    def to_binary(i)
        "%16b" % i
    end
end
