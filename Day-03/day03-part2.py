#!/usr/bin/python
#
# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806--->   ...

number = 289326

class Squares:
    
    def __init__(self):
        self.cells = {}

    def set(self, x, y, value):
        if x not in self.cells:
            self.cells[x] = {}
        self.cells[x][y] = value

    def get(self, x, y):
        if x not in self.cells or y not in self.cells[x]:
            return 0
        return self.cells[x][y]

    def adjecents(self, x, y):
        sum = 0
        for i in range(-1, 2):
            for j in range(-1, 2):
                if i != 0 or j != 0:
                    sum += self.get(x + i, y + j)
        return sum

def build_square(max_value):
    value = 1
    squares = Squares()
    squares.set(0, 0, value)

    directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    dir = 0
    x = 0
    y = 0
    wall = 1

    while value <= max_value:
        x += directions[dir][0]
        y += directions[dir][1]

        if x == wall and y == -wall:
            wall += 1

        if (dir == 0 and x == wall) or (dir == 1 and y == wall) or (dir == 2 and x == -wall) or (dir == 3 and y == -wall):
            dir = (dir + 1) % 4

        value = squares.adjecents(x, y)
        squares.set(x, y, value)

    return value

print(build_square(number))
