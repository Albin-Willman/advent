def split_layers(input, n, m)
	input.each_slice(n*m).to_a
end

def find_layer(layers)
	max_count = layers.first.length
	max_index = nil
	layers.each_with_index do |layer, i|
		value = layer.count("0")
		if value < max_count
			max_count = value
			max_index = i
		end
	end
	max_index
end

def calculate_value(layer)
	layer.count('1') * layer.count('2')
end


def find_pixel(layers, i)
	layers.each do |layer|
		return layer[i] unless layer[i] == "2"
	end
end

def decode(layers, n, m)
	res = []
	(n*m).times do |i|
		res << find_pixel(layers, i)
	end
	res
end

def print_image(image, n, m)
	n.times do |i|
		str = ''
		m.times do |j|
			str += image[i*m + j] == "1" ? "#" : " "
		end
		puts str
	end
end