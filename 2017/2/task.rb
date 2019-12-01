
class ChecksumCalculator
    attr_accessor :row_evaluator

    def initialize(row_evaluator)
        @row_evaluator = row_evaluator
    end

    def run(input)
        input.map { |e| row_evaluator.run(e) }.inject(0, :+)
    end
end

class DifferenceRowEvaluator
    def run(row)
        row_data = row.gsub(/\s+/m, ' ').strip.split(" ").map(&:to_i)
        row_data.max - row_data.min
    end
end

class DivisibleRowEvaluator
    def run(row)
        row_data = row.gsub(/\s+/m, ' ').strip.split(" ").map(&:to_i)
        row_data.each_with_index do |a, i|
            row_data.each_with_index do |b, j|
                next if i == j
                return a/b if a%b ==0
            end
        end
    end
end