words = "attack attach element ate anteater telephone apache antiquated tale late".split
processed_words = {start: [], all: []}

words.each do |w|
  processed_words[:start] << w.sub(/^at/, "@") if w =~ /^at/
  processed_words[:all] << w.sub(/at/, "@") if w =~ /at/
end

puts "Words starting 'at':", processed_words[:start], "Words containing 'at':", processed_words[:all]
