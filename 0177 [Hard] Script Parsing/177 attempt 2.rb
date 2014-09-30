class Actor
  attr_accessor :sentences

  def initialize()
    @sentences = []
  end

  def top_three_words()
    @sentences[0..2]
  end
end

class ScriptParser

  def initialize()
    @actors = Hash.new { |h, k| h[k] = Actor.new }
  end

  def find_scene(line)
    x = line.strip.scan(/^Scene (\d+)$/)
    if x == [] then nil else x[0] end
  end

  def count_stage_directions(line)
    line.strip.scan(/(\[.+\]|\(.+\))/).length
  end

  def remove_stage_directions(line)
    line.gsub(/(\[.+\]|\(.+\))/, "")
  end

  def get_actor(line)
    out = line.strip.scan(/^(.+):(.+)$/).flatten
    if out == [] then nil else out[0] end
  end

  def remove_actor(line)
    out = line.strip.scan(/^(.+):(.+)$/).flatten
    if out == [] then nil else out[1] end
  end

  def parse(filepath)
    line_count = 0
    curr_sentence = nil

    scene = 0
    actor = nil
    File.readlines(filepath).each do |line|
      
      # debug
      line_count +=1
      #if line_count > 20 then break end

      line = line.strip.chomp

      if line != nil && line != ""
        if find_scene(line)
          scene = find_scene(line)[0]
          actor = nil
        else
          count_stage_directions(line)
          line = remove_stage_directions(line)

          if get_actor(line) != nil
            actor = @actors[get_actor(line)]
            line = remove_actor(line)
          end

          # find completed sentences
          sentences = line.scan(/[^\.!?]+[\.!?]/)
          # find hanging sentences
          final_non_sentence = line.strip.scan(/[^\.!?]+$/)
          # process hanging sentences
          sentences.map! do |s|
            clean_line = s.strip.chomp
            if curr_sentence != nil
              clean_line = "#{curr_sentence} #{clean_line}"
              curr_sentence = nil
            end
            clean_line
          end
          # continue processing hanging sentences
          if final_non_sentence.first != nil
            curr_sentence = final_non_sentence.first.strip
          end

          sentences.each{ |s| actor.sentences << s } unless actor == nil
          sentences.each{ |s| puts "#{@actors.key(actor)} : #{s}" }
        end
      end
    end
  end
end

sp = ScriptParser.new
sp.parse("./input.txt")
#sp.actors.each {|a| puts top_three_words }