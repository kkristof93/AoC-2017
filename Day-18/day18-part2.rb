require 'io/console' 

instructions = []
File.open('input.txt') do |file|
  file.each_line do |line|
    instructions.push(line)
  end
end

class Program 

  def initialize(id, instructions)
    @id = id
    @instructions = instructions
    @pc = 0
    @queue = []
    @registers = {'p' => id}
    @send_count = 0
    @waiting = false
  end

  def set_receiver(program)
    @receiver = program
  end

  def receive(value)
    @queue.push(value)
  end

  def getval(arg)
    if arg.match(/^[[:alpha:]]+$/)
      return @registers[arg] || 0
    end
    return arg.to_i
  end

  def execute
    args = @instructions[@pc].split(' ')

    case args[0]
    when 'snd'
      @receiver.receive(getval(args[1]))
      @send_count += 1
    when 'set'
      @registers[args[1]] = getval(args[2])
    when 'add'
      @registers[args[1]] = getval(args[1]) + getval(args[2])
    when 'mul'
      @registers[args[1]] = getval(args[1]) * getval(args[2])
    when 'mod'
      @registers[args[1]] = getval(args[1]) % getval(args[2])
    when 'rcv'
      if @queue.length == 0 
        @waiting = true
        return
      else
        @waiting = false
        @registers[args[1]] = @queue.shift()
      end
    when 'jgz'
      if getval(args[1]) > 0
        @pc += getval(args[2])
        return
      end
    end

    @pc += 1
  end

  def finished
    return @pc >= @instructions.length
  end

  attr_reader :waiting
  attr_reader :send_count

end

p0 = Program.new(0, instructions)
p1 = Program.new(1, instructions)
p0.set_receiver(p1)
p1.set_receiver(p0)

while !p0.finished() && !p1.finished() && !(p0.waiting && p1.waiting)
  p0.execute()
  p1.execute()
end

puts p1.send_count
