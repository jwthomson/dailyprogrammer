acronyms = {
  "lol" => "laugh out loud",
  "dw"  => "don't worry",
  "hf"  => "have fun",
  "gg"  => "good game",
  "brb" => "be right back",
  "g2g" => "got to go",
  "wtf" => "what the fuck",
  "wp"  => "well played",
  "gl"  => "good luck",
  "imo" => "in my opinion"
}

["wtf that was unfair", "gl all hf", "imo that was wp. Anyway I've g2g"]
.each{ |t| puts(t.split(/\b/).map{ |w| if acronyms.keys.include? w then acronyms[w] else w end }.join)}