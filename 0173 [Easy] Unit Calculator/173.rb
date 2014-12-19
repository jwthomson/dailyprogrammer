lens = {  "metres"      => 1,
          "attoparsecs" => 0.03085678,
          "miles"       => 1609.34, 
          "inches"      => 0.0254
        }
weis = {  "kilograms" => 1,
          "pounds" => 0.4536,
          "ounces" => 0.02835,
          # UK Hogsheads
          "hogsheads of berylium" => 529.3
        }

def fix_hogs!(arr, idx)
  if [arr[idx], arr[idx+1], arr[idx+2]].join(' ').downcase == "hogsheads of berylium" then
    arr[idx] = "hogsheads of berylium"
    arr.delete_at(idx+1)
    arr.delete_at(idx+2)
  end
end

puts "Enter your conversion in the form \"5 metres to miles\""
puts "Valid units:", lens.keys.join(", "), weis.keys.join(", ")
inp = gets.chomp.split
fix_hogs!(inp, 1)
fix_hogs!(inp, 3)
val = inp[0].to_f * lens[inp[1]] / lens[inp[3]] if lens[inp[1]] && lens[inp[3]]
val = inp[0].to_f * weis[inp[1]] / weis[inp[3]] if weis[inp[1]] && weis[inp[3]]

if val then
  puts inp[0] + " " + inp[1] + " is " + val.to_s + " " + inp[3]
else
  puts inp[0] + " " + inp[1] + " cannot be converted to  " + inp[3]
  puts "please enter in the full name of the unit, and always use the plural form"
end
