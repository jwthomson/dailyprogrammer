require "date"
ARGV.each do |date|
  days_until = (DateTime.parse(date) - DateTime.now).to_f.ceil
  if days_until > 0
    puts "#{days_until} days until #{date}"
  else
    puts "#{date} is in the past!"
  end
end