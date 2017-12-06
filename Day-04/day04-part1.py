#!/usr/bin/python

valid = 0
with open("input.txt") as file:
    for line in file:
        phrases = line.replace("\n", "").split(" ")
        phrases_set = set(phrases)

        if len(phrases) == len(phrases_set):
            valid += 1

print(valid)
