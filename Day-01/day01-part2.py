#!/usr/bin/python

sum = 0
with open("input.txt") as file:
    for line in file:
        numbers = map(lambda x: int(x), line)
        length = len(numbers)
        half = length / 2

        for i in range(length):
            if numbers[i] == numbers[(i + half) % length]:
                sum += numbers[i]

print(sum)
