#!/usr/bin/python

valid = 0
with open("input.txt") as file:
    for line in file:
        phrases = line.replace("\n", "").split(" ")
        sorted_phrases = list(map(lambda x: ''.join(sorted(x)), phrases))
        sorted_phrases_set = set(sorted_phrases)

        if len(sorted_phrases) == len(sorted_phrases_set):
            valid += 1

print(valid)
