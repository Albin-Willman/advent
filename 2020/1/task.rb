
class NumberFinder
	def run(input, length)
		input.permutation(length).each { |arr| return arr.inject(:*) if arr.sum == 2020 }
	end
end
