#!/usr/bin/python

checksum = 0
with open("input.txt") as file:
    for line in file:
        values = line.replace("\n", "").split("\t")
        numbers = list(map(lambda x: int(x), values))

        diff = max(numbers) - min(numbers)
        checksum += diff

print(checksum)
