local state = require("Markov")

local s = {
  a = state('a'),
  b = state('b'),
  c = state('c'),
  d = state('d'),
}

s.a.set_weight(s.a, 5)
s.a.set_weight(s.b, 1)
s.a.set_weight(s.c, 0)
s.a.set_weight(s.d, 0)

s.b.set_weight(s.a, 0)
s.b.set_weight(s.b, 5)
s.b.set_weight(s.c, 1)
s.b.set_weight(s.d, 0)

s.c.set_weight(s.a, 0)
s.c.set_weight(s.b, 0)
s.c.set_weight(s.c, 5)
s.c.set_weight(s.d, 1)

s.d.set_weight(s.a, 1)
s.d.set_weight(s.b, 0)
s.d.set_weight(s.c, 0)
s.d.set_weight(s.d, 5)

local current = s.a
local output_str = ""
for  i = 1,80 do
  output_str = output_str .. " " .. current.value .. (1 % 5 == 0 and "\n" or "")
  current = current.get_next()
end
print(output_str)