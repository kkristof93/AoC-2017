map = []
File.open('input.txt') do |file|
  file.each_line do |line|
    map.push(line)
  end
end

x = 0
y = map[0].index('|')

dirX = 1
dirY = 0

steps = 0

while map[x][y] != ' '
  c = map[x][y]

  steps += 1

  if c == '+'
    if dirX != 0
      dirX = 0
      dirY = map[x][y + 1] != ' ' ? 1 : -1
    else 
      dirX = map[x + 1][y] != ' ' ? 1 : -1
      dirY = 0
    end
  end

  x += dirX
  y += dirY
end

puts steps
