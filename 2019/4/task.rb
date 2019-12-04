class PasswordValidator

	def count_passwords(from, to)
		valid_count = 0
		(from..to).each do |i|
			valid_count += 1 if valid?(i)
		end
		valid_count
	end

	def valid?(pwd)
		s = pwd.to_s.split('')
		return false unless has_adjacent?(s)
		(0..(s.length - 2)).each do |i|
			return false if s[i] > s[i+1]
		end
		true
	end

	def has_adjacent?(s)
		(0..(s.length - 2)).each do |i|
			# return true if 2 == adjacent_count(s,i)
			return true if 2 >= adjacent_count(s,i) # switch to this for part 1
		end
		false
	end

	def adjacent_count(s,i)
		c = s[i]
		count = 1
		index = 1
		while i-index >= 0 && s[i-index] == c
			index += 1
			count += 1
		end
		index = 1
		while s[i+index] == c
			index += 1
			count += 1
		end
		count
	end
end