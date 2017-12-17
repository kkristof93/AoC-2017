moves = []
File.open('input.txt') do |file|
  line = file.gets
  moves = line.split(',')
end

programs = *('a'..'p')

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

puts programs.join('')
