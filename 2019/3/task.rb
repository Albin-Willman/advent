class Wires
	attr_accessor :wire_1, :wire_2, :intersections

	def initialize
		@intersections = []
	end

	def add_wire_1(input)
		@wire_1 = add_wire(input, false)
	end

	def add_wire_2(input)
		@wire_2 = add_wire(input, true)
	end

	def distance_to_closest_intersction
		@intersections.map { |int| int[0].abs + int[1].abs }.min
	end

	def distance_to_closest_intersction_by_wire
		@intersections.map { |int| @wire_1["#{int[0]}-#{int[1]}"] + @wire_2["#{int[0]}-#{int[1]}"] }.min

	end

	def add_wire(input, check_for_intersection)
		x, y = 0, 0
		wire = {}
		step = 1
		input.each do |cmd|
			steps = cmd[1..-1].to_i
			if is_horizontal?(cmd[0])
				steps.times do 
					x += get_step(cmd[0])
					check(x,y) if check_for_intersection
					wire["#{x}-#{y}"] = step
					step += 1
				end
			else
				steps.times do 
					y += get_step(cmd[0])
					check(x,y) if check_for_intersection
					wire["#{x}-#{y}"] = step
					step += 1
				end
			end
		end
		wire
	end

	def check(x,y)
		@intersections << [x,y] if @wire_1["#{x}-#{y}"]
	end

	def is_horizontal?(cmd)
		return true if ["R", "L"].include?(cmd)
		false
	end

	def get_step(cmd)
		return 1 if ["R", "U"].include?(cmd)
		-1
	end

end