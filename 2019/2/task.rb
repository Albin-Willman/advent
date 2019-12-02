class Computer
	attr_accessor :ip, :memory, :instruction_length

	def initialize(memory, noun, verb)
		@memory = memory.clone
		@memory[1] = noun
		@memory[2] = verb
		@ip = 0
		@instruction_length = 4
	end

	def run
		return memory.first if memory[ip] == 99
		perform_operand(memory[ip])
		@ip += @instruction_length
		run
	end

	def perform_operand(n)
		case n
		when 1 then return plus
		when 2 then return multiply
		end
	end

	def plus
		@memory[memory[ip + 3]] = memory[memory[ip + 2]] + memory[memory[ip + 1]]
	end

	def multiply
		@memory[memory[ip + 3]] = memory[memory[ip + 2]] * memory[memory[ip + 1]]
	end


end
