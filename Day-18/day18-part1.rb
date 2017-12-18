instructions = []
File.open('input.txt') do |file|
  file.each_line do |line|
    instructions.push(line)
  end
end

$registers = {}
freq = 0

def getval(arg)
  if arg.match(/^[[:alpha:]]+$/)
    return $registers[arg] || 0
  end
  return arg.to_i
end

pc = 0
while pc < instructions.length 
  args = instructions[pc].split(' ')

  case args[0]
  when 'snd'
    freq = getval(args[1])
  when 'set'
    $registers[args[1]] = getval(args[2])
  when 'add'
    $registers[args[1]] = getval(args[1]) + getval(args[2])
  when 'mul'
    $registers[args[1]] = getval(args[1]) * getval(args[2])
  when 'mod'
    $registers[args[1]] = getval(args[1]) % getval(args[2])
  when 'rcv'
    if getval(args[1]) != 0
      break
    end
  when 'jgz'
    if getval(args[1]) > 0
      pc += getval(args[2])
      next
    end
  end

  pc += 1
end

puts freq
