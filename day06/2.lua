times = {53897698}
distances = {313109012141201}
total = 1

for i = 1, 1 do
	r = 0
	t = times[i]
	d = distances[i]
	
	lo = (-t + (t * t - 4 * d) ^ 0.5) / -2
	hi = (-t - (t * t - 4 * d) ^ 0.5) / -2
	
	loc = math.ceil(lo)
	hif = math.floor(hi)
	
	r = (hif - loc + 1)
	
	if lo==loc then
	 	r = r - 1
	end
	if hi==hif then
		r = r - 1
	end
	
	total = total * r
end

print(total)
