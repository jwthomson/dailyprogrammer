class ScriptStats
  attr_accessor :characters, :words, :num_directions, :num_lines, :num_words

  def initialize()
    @characters = Hash.new { |h, k| h[k] = Hash.new { |i, j| i[j] = 0 } }
    @words = Hash.new { |h, k| h[k] = 0 }
    @num_directions = 0
    @num_lines = 0
    @num_words = 0
  end

  def output()
    puts "Line count: #{@num_lines}" 
    puts "Word count: #{@num_words}" 
    puts "Direction count: #{@num_directions}"
    puts "Top 3 words:"
    @words.sort_by{ |i,j| j }.reverse[1..3].each{ |w, n| print "#{w} => #{n}\n"}
    puts "Top 3 words per character:"
    @characters.each do |c, ws| 
      if ws == nil || ws.size == 0 then break end
      ws.sort_by{ |i,j| j }.reverse[1..3].each do |w, n|
        print "#{c}: #{w} => #{n}\n"
      end
    end
  end
end

class ScriptParser

  attr_accessor :stats, :scene_stats

  def parse_line(line)
    
    regexes = {
      blank: /^$|THE END./,
      scene: /^Scene (\d+)$/,
      new_line: /^(.+):(.+)$/,
      next_line: /^(.+)$/,
    }

    # Remove actions
    line.gsub!(/(\[.+\]|\(.+\))/) do |match|
      @stats.num_directions += 1
      @scene_stats[@state[:scene]].num_directions += 1
      ""
    end
    regexes.each { |k, v| regexes[k] = line.scan(v) }
    regexes.each { |k, v| if regexes[k] != nil then parse_specific(k, regexes[k]); return k end }

  end

  def parse_specific(type, matches)

    if type == :blank
      @state[character: nil, speech: nil]
    
    elsif type == :scene
      @state[character: nil, speech: nil]
      @state[:scene] = matches[0].to_i
    
    else # :new_line and :next_line
      
      if type == :new_line
        @stats.characters[matches[0]] = @stats.characters[matches[0]] or Hash.new { |h, k| h[k] = 0}
        @scene_stats[@state[:scene]].characters[matches[0]] = @scene_stats[@state[:scene]].characters[matches[0]] or Hash.new { |h, k| h[k] = 0}
        @state[:character] = matches[0]
        matches.slice! 0
      end

      @state[:speech] = matches[0].strip
      if @state[:speech].length > 0
        words = @state[:speech].scan(/\w+/)
        @stats.num_words += words.length
        @scene_stats[@state[:scene]].num_words += words.length
        words.each do |w|
          @stats.words[w.strip] += 1 
          @scene_stats[@state[:scene]].words[w.strip] += 1 
          @stats.characters[@state[:character]][w.strip] += 1 
          @scene_stats[@state[:scene]].characters[@state[:character]][w.strip] += 1 
        end
      end
    end

  end

  def initialize()
    @stats = ScriptStats.new
    @scene_stats = Hash.new{ |h, k| h[k] = ScriptStats.new }
    @state = {scene: 0, character: nil, speech: nil}
  end

  def parse(filepath)
    
    File.readlines(filepath).each do |line|
      @stats.num_lines += 1
      @scene_stats[@state[:scene]].num_lines += 1
      clean_line = line.strip.chomp
      result = parse_line(clean_line) 
      puts_state(result)

      if @stats.num_lines >= 400 then break end
    end
  end

  def puts_state(result)
    out = @stats.num_lines.to_s.rjust(4) + " "
    if result == :scene
        puts out + "SCN #" + (@state[:scene] or 0).to_s
    elsif result == :new_line
        puts out + (@state[:character] or "n/a").rjust(9)[0...9]+ " " + (@state[:speech] or "n/a")
    elsif result == :next_line
        puts out + " " * 10 + (@state[:speech] or "n/a")
    end
  end
end

sp = ScriptParser.new
sp.parse("./input.txt")
puts "Overall stats\n----------------------"
sp.stats.output
