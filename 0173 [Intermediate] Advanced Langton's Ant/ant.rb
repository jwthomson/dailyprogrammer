class Square
  @@strings = [" ", "#", "-", "+", "=", "~", "'", "/", "\\", "&", "*", ","]

  def self.getStringsLength
    @@strings.length  
  end

  def self.set(input)
    @@colourBehaviour = input.downcase.chars.map{|e| e == "l"}
  end

  def initialize
    @colour = 0
  end

  def enter
    oldColour = @colour
    @colour = (@colour + 1) % @@colourBehaviour.length
    @@colourBehaviour[oldColour]
  end

  def to_s
    return @@strings[@colour]
  end
end

def print_squares(squares)
  squares.each do |squareLn|
    squareLn.each { |s| print s.to_s }
    puts
  end
end

def turn(direction, turnCW)
  if turnCW then
    direction+=1
  else
    direction+=3
  end
  direction %= 4
end

## Setup
puts "Enter up to " + Square.getStringsLength().to_s + " letters, L or R!"
Square.set(gets.chomp)
puts "How many steps do you want simulated?"
steps = gets.chomp.to_i
direction = 0
size = 78
ant = { x: size/2, y: size/2}
squares = Array.new(size).map{ Array.new(size).map{ Square.new } }

## Main program loop
while steps > 0 do
  # Get the new direction
  direction = turn(direction, squares[ant[:x]][ant[:y]].enter)
  # Move in the direction we are facing
  if direction == 0 then
    ant[:y] -= 1
  elsif direction == 2 
    ant[:y] += 1
  elsif direction == 1
    ant[:x] -= 1
  else
    ant[:x] += 1
  end
  ant[:x] += size
  ant[:x] %= size
  ant[:y] += size
  ant[:y] %= size
  steps -= 1
end
print_squares(squares)
