require './datefixer'
require 'open-uri'

# Opens custom url OR dates.txt OR challenge data url (in that order)
def get_dates(options = {})
  # networks and user input and file io, oh my!
  begin
    if options[:url]
      date_file = open(options[:url]) { |f| f.read }
      File.write('dates.txt', date_file)
    elsif File.exist?('dates.txt')
      date_file = open('dates.txt'){ |f| f.read }
    else
      url = 'https://gist.github.com/coderd00d/a88d4d2da014203898af/raw/73e9055107b5185468e2ec28b27e3b7b853312e9/gistfile1.txt'
      date_file = open(url) { |f| f.read }
      File.write('dates.txt', date_file)
    end
  rescue => ex
    puts 'Exception!'
    puts ex.message
    date_file = ""
  end
  date_file.lines.each { |d| d.chomp! }
end

if __FILE__ == $0
  dates = get_dates()
  fixed_dates = []
  dates.each{ |date| fixed_dates << "#{date.rjust(12)} => #{DateFixer.fix_date(date)}" }
  File.write('fixed_dates.txt', fixed_dates*"\n")
  puts "Complete. #{dates.length} date#{dates.length == 1 ? "" : "s"} processed."
end
