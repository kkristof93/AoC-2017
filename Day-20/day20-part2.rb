class Vector
  def initialize(str)
    args = str.split(',')
    @x = args[0].to_i
    @y = args[1].to_i
    @z = args[2].to_i
  end

  def distance
    return @x.abs + @y.abs + @z.abs
  end

  def add(p)
    @x += p.x
    @y += p.y
    @z += p.z
  end

  def equals(p)
    return @x == p.x && @y == p.y && @z == p.z
  end

  attr_reader :x
  attr_reader :y
  attr_reader :z
end

class Particle
  def initialize(id, str)
    args = str.split(', ')
    @id = id
    @p = Vector.new(args[0][3..-2])
    @v = Vector.new(args[1][3..-2])
    @a = Vector.new(args[2][3..-2])
  end

  def tick
    @v.add(@a)
    @p.add(@v)
  end

  attr_reader :id
  attr_reader :p
  attr_reader :v
  attr_reader :a
end

particles = []
File.open('input.txt') do |file|
  file.each_line.with_index do |line, idx|
    particles.push(Particle.new(idx, line))
  end
end

for i in (0..100)
  particles.each{ |p| p.tick() }

  particles.each{ |p1| 
    duplicates = particles.select{ |p2| p1.id != p2.id && p1.p.equals(p2.p) }.map{ |p| p.id }
    if duplicates.length > 0 
      duplicates.push(p1.id)
      particles.delete_if{ |p| duplicates.include?(p.id) }
    end
  }
end

puts particles.length
