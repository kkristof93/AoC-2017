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

letters = []

while map[x][y] != ' '
  c = map[x][y]

  if map[x][y].match(/^[[:alpha:]]+$/)
    letters.push(c)
  end

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

puts letters.join('')
