#!/usr/bin/python

sum = 0
with open("input.txt") as file:
    for line in file:
        numbers = map(lambda x: int(x), line)
        length = len(numbers)

        for i in range(length):
            if numbers[i] == numbers[(i + 1) % length]:
                sum += numbers[i]

print(sum)
