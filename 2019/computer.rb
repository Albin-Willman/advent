class Computer
	attr_accessor :ip, :memory, :input_system, :output, :relative_base

	def initialize(memory, input_system = 0)
		@memory = memory.clone
		@ip = 0
		@relative_base = 0
		@input_system = input_system
	end

	def run
		while true
			steps = perform_operand(@memory[ip])
			return false if steps == 99
			return @output if steps == 98
			@ip += steps
		end
	end

	def rerun(input_system)
		@input_system = input_system
		run
	end

	def run_till_end
		res = true
		while res
			res = run
			puts res
		end
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
		when 1 then return plus(parts[2], parts[1], parts[0])
		when 2 then return multiply(parts[2], parts[1], parts[0])
		when 3 then return get_input(parts[2])
		when 4 then return send_output(parts[2])
		when 5 then return jump_if_true(parts[2], parts[1])
		when 6 then return jump_if_false(parts[2], parts[1])
		when 7 then return less_than(parts[2], parts[1], parts[0])
		when 8 then return equals(parts[2], parts[1], parts[0])
		when 9 then return adjust_relative_base(parts[2])
		when 99 then return 99
		else
			puts @ip
			puts "#{@memory}"
			raise "unkown command"
		end
	end

	def jump_if_true(mode1, mode2)
		value1 = get_value(ip + 1, mode1)
		if value1 != 0
			@ip = (get_value(ip + 2, mode2)) 
			return 0
		end
		3
	end

	def jump_if_false(mode1, mode2)
		value1 = get_value(ip + 1, mode1)
		if value1 == 0
			@ip = (get_value(ip + 2, mode2)) 
			return 0
		end
		3
	end

	def less_than(mode1, mode2, mode3)
		value1 = get_value(ip + 1, mode1)
		value2 = get_value(ip + 2, mode2)
		write_value(ip + 3, (value1 < value2 ? 1 : 0), mode3) 
		4
	end

	def equals(mode1, mode2, mode3)
		value1 = get_value(ip + 1, mode1)
		value2 = get_value(ip + 2, mode2)
		write_value(ip + 3, (value1 == value2 ? 1 : 0), mode3) 
		4
	end


	def send_output(mode)
		value1 = get_value(ip + 1, mode)
		if value1 != 0
			@output = value1
			@ip += 2
			return 98
		end
		2
	end

	def get_input(mode)
		value = nil
		if @input_system == @input_system.to_i
			value = @input_system
		else
			value = @input_system.get_value(ip)
		end
		write_value(ip + 1, value, mode)
		2
	end

	def adjust_relative_base(mode1)
		value = get_value(ip + 1, mode1)
		@relative_base += value
		2
	end

	def plus(mode1, mode2, mode3)
		value1 = get_value(ip + 1, mode1)
		value2 = get_value(ip + 2, mode2)
		write_value(ip + 3, value1 + value2, mode3) 
		4
	end

	def multiply(mode1, mode2, mode3)
		value1 = get_value(ip + 1, mode1)
		value2 = get_value(ip + 2, mode2)
		write_value(ip + 3, value1 * value2, mode3) 
		4
	end

	private

	def write_value(position, value, mode)
		write_location = memory[position]
		write_location += @relative_base if mode == "2"

		@memory += Array.new(write_location - memory.length, 0) if write_location >= memory.length
		
		@memory[write_location] = value
	end

	def get_value(position, mode)
		position = memory[position] if mode == "0"
		position = memory[position] + relative_base if mode == "2"

		@memory += Array.new(position - memory.length + 1, 0) if position >= memory.length
		memory[position]
	end


end
