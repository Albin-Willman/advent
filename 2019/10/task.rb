require 'cmath'
class AstroidMap
	attr_accessor :astroids, :laser, :vaporized_astroids
	def initialize(input)
		parse(input)
	end

	def parse(input)
		@astroids = {}
		input.each_with_index do |row, y|
			row.each_with_index do |cell, x|
				@astroids["#{x}-#{y}"] = Astroid.new(x,y) if cell == "#"
			end
		end
	end

	def compute_visibility
		@astroids.each do |k, v|
			v.number_of_visible_astroids = count_visible_astroids(v)
		end
	end

	def count_visible_astroids(astroid)
		astroids.values.count { |a| !obstructed_line_of_sight(astroid, a)}
	end

	def vaporize(n)
		@vaporized_astroids = []
		visible_astroids = []
		while @vaporized_astroids.length < n
			if visible_astroids.length == 0
				visible_astroids = @astroids.values.select { |a| !obstructed_line_of_sight(laser, a)}
				visible_astroids.map! { |a| [compute_angle(a), a] }.sort_by!(&:first)
			end
			a = visible_astroids.shift.last
			@vaporized_astroids << a
			@astroids.delete("#{a.x}-#{a.y}")
		end
	end

	def compute_angle(a)
		direction = get_direction(laser, a)

		angle = Math::PI/2
		angle = CMath.atan(direction.first.abs.to_f/direction.last.abs) unless direction.last == 0
		if direction[0] >= 0 && direction[1] < 0
			return angle
		elsif direction[0] >= 0 && direction[1] >= 0
			return Math::PI - angle
		elsif direction[0] < 0 && direction[1] >= 0
			return Math::PI + angle
		end
		2*Math::PI - angle
	end

	def shot		
		hit = obstructed_line_of_sight(laser, target)
		hit = @astroids["#{@target.x}-#{target.y}"] ? "#{@target.x}-#{target.y}" : false unless hit
		puts "hit: #{hit}" if hit
		@vaporized_astroids << @astroids.delete(hit) if hit
	end

	def aim
		if !@target
			@target = Astroid.new(@laser.x, 0)
			@last_dir = :y
			return
		end

		if @last_dir == :x
			target.y = target.y + (target.x < laser.x ? -1 : 1)
			@last_dir = :y
		else 
			target.x = target.x + (target.y < laser.y ? 1 : -1)
			@last_dir = :x
		end
	end

	def place_laser
		max_count = astroids.values.map(&:number_of_visible_astroids).max
		@laser = astroids.values.find {|a| a.number_of_visible_astroids == max_count }
	end

	def obstructed_line_of_sight(a, b)
		return true if a.x == b.x && a.y ==b.y
		direction = get_direction(a, b)
		i = 0		
		loop do
			i += 1
			px = a.x + direction[0]*i
			py = a.y + direction[1]*i
			return false if (px == b.x && py == b.y)
			return true if astroids["#{px}-#{py}"]
		end
	end

	def get_direction(a, b)
		dx = b.x - a.x		
		dy = b.y - a.y
		i = 2
		while i <= dx.abs || i <= dy.abs
			if dx.abs % i == 0 && dy.abs % i == 0
				dx = dx/i
				dy = dy/i
			else
				i += 1
			end
		end
		[dx, dy]
	end
end

class Astroid
	attr_accessor :number_of_visible_astroids, :x, :y

	def initialize(x,y)
		@x, @y = x, y 
	end

	def to_s 
		"#{x}-#{y}"
	end
end