local function markov_state(value)
  if value == nil then return nil end
  
  local s = {}
  s.value = value
  s.weights = {}
  s.count = 0

  s.set_weight = function(k, v)
    if k == nil or (v~= nil and type(v) ~= "number") then return end

    local diff = (s.weights[k] ~= nil and (v - s.weights[k]) or v)
    s.count = s.count + diff
    s.weights[k] = v
  end

  s.inc_weight = function(k, v)
    if k == nil or v == nil or type(k) ~= "table" or type(v) ~= "number" then
      return
    end

    local old = (s.weights[k] ~= nil and s.weights[k] or 0)
    s.count = s.count + v
    s.weights[k] = old + v
  end

  s.get_next = function()
    if s.count == 0 then return nil end

    local r = math.random()
    local c = 0
    for k,v in pairs(s.weights) do
      c = c + (v/s.count)
      if c > r then return k end
    end
  end

  return s
end

return markov_state