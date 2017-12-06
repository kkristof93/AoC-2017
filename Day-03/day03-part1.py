#!/usr/bin/python
#
# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23---> ...

from math import *

number = 289326

def distance(num):
    c = ceil(sqrt(num))
    if c % 2 == 0:
        c += 1

    start = pow(c - 2, 2) + floor(c / 2)

    axes = []
    for i in range(0, 4):
        axes.append(start + i * (c - 1))

    dist = list(map(lambda x: abs(num - x), axes))

    return int(floor(c / 2) + min(dist))

print(distance(number))
