class Computer
	attr_accessor :ip, :memory, :system_id

	def initialize(memory, system_id)
		@memory = memory.clone
		@ip = 0
		@system_id = system_id
	end

	def run
		steps = perform_operand(@memory[ip])
		return memory.first if steps == 99
		@ip += steps
		run
	end

	def perform_operand(n)
		parts = ["0","0","0","0","0"]
		if n > 99
			parts = n.to_s.split('')
			while parts.length < 5 
				parts = ["0"] + parts
			end
			n = (parts[3] + parts[4]).to_i

		end
		case n
		when 1 then return plus(parts[2], parts[1])
		when 2 then return multiply(parts[2], parts[1])
		when 3 then return get_input(parts[2])
		when 4 then return send_output(parts[2])
		when 5 then return jump_if_true(parts[2], parts[1])
		when 6 then return jump_if_false(parts[2], parts[1])
		when 7 then return less_than(parts[2], parts[1])
		when 8 then return equals(parts[2], parts[1])
		when 99 then return 99
		else
			puts @ip
			puts "#{@memory}"
			raise "unkown command"
		end
	end

	def jump_if_true(mode1, mode2)
		value1 = mode1 == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		if value1 != 0
			@ip = (mode2 == "0" ? memory[memory[ip + 2]] : memory[ip + 2]) 
			return 0
		end
		3
	end

	def jump_if_false(mode1, mode2)
		value1 = mode1 == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		if value1 == 0
			@ip = (mode2 == "0" ? memory[memory[ip + 2]] : memory[ip + 2]) 
			return 0
		end
		3
	end

	def less_than(mode1, mode2)
		value1 = mode1 == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		value2 = mode2 == "0" ? memory[memory[ip + 2]] : memory[ip + 2]
		@memory[memory[ip + 3]] = (value1 < value2 ? 1 : 0)
		4
	end

	def equals(mode1, mode2)
		value1 = mode1 == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		value2 = mode2 == "0" ? memory[memory[ip + 2]] : memory[ip + 2]
		@memory[memory[ip + 3]] = (value1 == value2 ? 1 : 0)
		4
	end


	def send_output(mode)
		value1 = mode == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		puts "Output: #{value1}"
		if value1 != 0
			return 99
		end
		2
	end

	def get_input(mode)
		@memory[memory[ip + 1]] = @system_id
		2
	end

	def plus(mode1, mode2)
		value1 = mode1 == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		value2 = mode2 == "0" ? memory[memory[ip + 2]] : memory[ip + 2]
		@memory[memory[ip + 3]] = value1 + value2
		4
	end

	def multiply(mode1, mode2)
		value1 = mode1 == "0" ? memory[memory[ip + 1]] : memory[ip + 1]
		value2 = mode2 == "0" ? memory[memory[ip + 2]] : memory[ip + 2]
		@memory[memory[ip + 3]] = value1 * value2
		4
	end


end
