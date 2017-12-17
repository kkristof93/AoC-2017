moves = []
File.open('input.txt') do |file|
  line = file.gets
  moves = line.split(',')
end

programs = *('a'..'p')

def dance(programs, moves)
  moves.each { |move|
    case move[0]
    when 's'
      num = move[1..-1].to_i
      a = programs[-num..-1]
      b = programs[0..(-num - 1)]
      programs = a + b 

    when 'x'
      i = move.index('/')
      a = move[1..(i - 1)].to_i
      b = move[(i + 1)..-1].to_i
      programs[a], programs[b] = programs[b], programs[a]
      
    when 'p'
      i = move.index('/')
      a = programs.index(move[1])
      b = programs.index(move[3])
      programs[a], programs[b] = programs[b], programs[a]
    end
  }
  return programs
end

seen = []
for i in (1..1e9)
  if seen.include?(programs.join(''))
    break
  end
  
  seen.push(programs.join(''))
  programs = dance(programs, moves)
end

puts seen[(1e9 % seen.length)]
