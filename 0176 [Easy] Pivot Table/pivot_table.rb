days = %w(Mon Tue Wed Thu Fri Sat Sun)
data = Hash.new { |h, k| h[k] = Array.new(7, 0) }

File.foreach("./windfarm.dat") do |ln| 
  tower, day, kwh = ln.split
  data[tower][days.index(day)] += kwh.to_i
end

# Heading
heading = "Tower  |" + days.map{ |d| d.rjust(6) }.join
puts heading, "=" * heading.length

# Sort by turbine ID
data = data.to_a.sort { |a, b| a[0] <=> b[0] }

data.each do |dt|
  tower_id_padded = dt[0].ljust("Tower  ".length)
  tower_data_padded = dt[1].map{ |d| d.to_s.rjust(6) }.join
  puts  "#{tower_id_padded}|#{tower_data_padded}"
end
