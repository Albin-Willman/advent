class OrbitMap
	attr_accessor :orbiting_objects

	def initialize
		@orbiting_objects = []
	end

	def map_value
		orbiting_objects.map(&:value).sum
	end

	def read_map(input)
		input.each do |line|
			place(line)
		end
	end

	def place(line)
		orbiters = line.split(")")
		orbited = find_or_init(orbiters.first)
		orbiter = find_or_init(orbiters.last)
		orbited.add(orbiter)
		orbiter.add_parent(orbited)
	end

	def find_or_init(name)
		o = @orbiting_objects.find { |o| o.name == name } 
		unless o 
			o = OrbitObject.new(name)
			@orbiting_objects << o
		end
		o
	end

	def find_closest_path(o1, o2)
		a1 = o1.ancestral_tree
		a2 = o2.ancestral_tree
		(a1.keys & a2.keys).map { |key| a1[key] + a2[key] }.min

	end

end

class OrbitObject
	attr_accessor :orbiting_objects, :name, :parents

	def initialize(name)
		@name = name
		@orbiting_objects = []
		@parents = []
	end

	def add_parent(o)
		@parents << o
	end

	def ancestral_tree(level = 0)
		tree = {}
		@parents.each do |p|
			p.ancestral_tree(level + 1).each do |k, v|
				tree[k] = v unless tree[k] && tree[k] < v
			end
			tree[p.name] = level unless tree[p.name] && tree[p.name] < level
		end
		tree
	end

	def add(o)
		@orbiting_objects << o
	end

	def value
		@orbiting_objects.length + @orbiting_objects.inject(0) { |s, o| s + o.value }
	end
end