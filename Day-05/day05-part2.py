#!/usr/bin/python

jumps = []
with open("input.txt") as file:
    for line in file:
        jumps.append(int(line))

steps = 0
instruction = 0
while instruction < len(jumps):
	offset = jumps[instruction]
	if offset >= 3:
		jumps[instruction] = offset - 1
	else:
		jumps[instruction] = offset + 1
	instruction += offset
	steps += 1

print(steps)
