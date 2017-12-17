steps = 335
spinlock = [0]
i = 0

for num in (1..2017)
  i = (i + steps) % spinlock.length + 1
  spinlock = spinlock[0..(i - 1)] + [num] + spinlock[i..-1]
end

puts spinlock[i + 1]
