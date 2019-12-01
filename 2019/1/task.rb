
def fuel_required(weight)
	weight/3 - 2
end

def total_fuel_required(weight)
	sum = 0
	fuel = fuel_required(weight)
	while fuel > 0
		sum += fuel
		fuel = fuel_required(fuel)
	end

	sum
end

def sum_fuel(modules)
	modules.inject(0) { |s, e| s + fuel_required(e) }
end

def total_fuel_sum(modules)
	modules.inject(0) { |s, e| s + total_fuel_required(e) }
end