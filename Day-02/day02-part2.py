#!/usr/bin/python

checksum = 0
with open("input.txt") as file:
    for line in file:
        values = line.replace("\n", "").split("\t")
        numbers = list(map(lambda x: int(x), values))

        div = 0
        for a in numbers:
            for b in numbers:
                if a == b:
                    continue
                if a % b == 0:
                    div = a / b
                    break

        checksum += div

print(checksum)
