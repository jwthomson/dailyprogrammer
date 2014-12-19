require "highline/import"

def generate_level(size)
  size += 2
  level = Array.new(size) do |i|
    i = (i % (size - 1) == 0) ? String.new("\#"*size) : String.new("\#" + " "*(size - 2) + "\#")
  end
  # 100 random elements (badly generated, high chance of overlaps!)
  8.times{ level[rand(1...size-1)][rand(1...size-1)] = "§"  }
  12.times{ level[rand(1...size-1)][rand(1...size-1)] = "?"  }
  20.times{ level[rand(1...size-1)][rand(1...size-1)] = "$"  }
  20.times{ level[rand(1...size-1)][rand(1...size-1)] = "c"  }
  10.times{ level[rand(1...size-1)][rand(1...size-1)] = "-"  }
  30.times{ level[rand(1...size-1)][rand(1...size-1)] = "\#" }
  level
end

def play()
  # init
  steps = 100
  score = 0
  player = [10, 10]
  move_list = {
    "w" => [-1,  0],
    "a" => [ 0, -1],
    "s" => [+1,  0],
    "d" => [ 0, +1]
  }
  level = generate_level(20)
  level[player[0]][player[1]] = "@"
  puts level

  # play!
  loop do 
    puts "Steps: #{steps}\nScore: #{score}"
    c = ask("") do |q|
              q.echo      = false
              q.character = true
              q.validate  = /[#{move_list.keys}]/
              q.responses[:not_valid]    = 'Please enter w,a,s, or d!'
             end
    next_step = player.zip(move_list[c.chomp] || [0, 0]).map{|x| x.inject(:+)}
    next_char = level[next_step[0]][next_step[1]] 
    unless next_char == "\#"
      level[player[0]][player[1]] = " "
      player = next_step
      steps -= 1
      case next_char # did we step on some treasure?
      when "§" then score += 10
      when "?" then score += rand(10)+1
      when "$" then score += 4
      when "c" then score += 1
      when "-" then score -= 5 # uh oh, cursed treasure!
      end
    end
    level[player[0]][player[1]] = "@"
    puts level
    break if steps < 0
  end

  puts "Game over!\nScore: #{score}"
end

play()