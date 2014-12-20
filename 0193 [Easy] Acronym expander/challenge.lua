local rex = require("rex_pcre")

local acronyms = setmetatable(
  {
    lol = "laugh out loud",
    dw  = "don't worry",
    hf  = "have fun",
    gg  = "good game",
    brb = "be right back",
    g2g = "got to go",
    wtf = "what the fuck",
    wp  = "well played",
    gl  = "good luck",
    imo = "in my opinion"
  },
  {
    __index = function(t, k)
      return k
    end
  }
)

local sentences = {
  "wtf that was unfair",
  "gl all hf",
  "imo that was wp. Anyway I've g2g"
}

for _,sentence in pairs(sentences) do
  local out = ""
  for w in rex.split(sentence, "\\b") do
    out = out .. acronyms[w]
  end
  print(out)
end