require "../computer.rb"

 class AmplifierChain

	def run(phases, input, output)
		phases.each do |phase|
			ai = AmplifierInput.new(phase, output)
			c = Computer.new(input, ai)
			output = c.run
			
			return false unless output
		end
		output
	end

	def run_looped(phases, input, output)
		computers = []
		e_output = output
		5.times { computers << Computer.new(input)}
		while true
			phases.each_with_index do |p, i|
				ai = AmplifierInput.new(p, output)
				output = computers[i].rerun(ai)
				return e_output unless output
			end
			e_output = output
		end
	end

	def find_max_output(input)
		value = 0
		(0..4).to_a.permutation.each do |p|
			output = run(p, input, 0)
			value = output if output > value
		end
		value
	end

	def find_max_output_looped(input)
		value = 0
		(5..9).to_a.permutation.each do |p|
			output = run_looped(p, input, 0)
			value = output if output > value
		end
		value
	end
end

class AmplifierInput
	attr_accessor :values
	def initialize(first, second)
		@values = [first, second]
	end
	def to_i
		"No"
	end
	def get_value(ip)
		return values.first if ip == 0
		@values.last
	end
end
