steps = 335
first = 0
i = 0

for num in (1..5e7)
  i = (i + steps) % num + 1
  
  if i == 1
  	first = num
  end
end

puts first
