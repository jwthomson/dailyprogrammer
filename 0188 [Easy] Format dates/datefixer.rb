module DateFixer

  # Variable extraction from regex is the best thing ever
  REGEXES = [
    /^(?<y>[0-9]{4})-(?<m>[01][0-9])-(?<d>[0-3][0-9])$/,      # yyyy-mm-dd ** No change required **
    /^(?<m>[01][0-9])\/(?<d>[0-3][0-9])\/(?<y>[0-9]{2})$/,    # mm/dd/yy
    /^(?<m>[01][0-9])#(?<y>[0-9]{2})#(?<d>[0-3][0-9])$/,      # mm#yy#dd
    /^(?<d>[0-3][0-9])\*(?<m>[01][0-9])\*(?<y>[0-9]{4})$/,    # dd*mm*yyyy
    /^(?<m>[A-Z][a-z]{2}) (?<d>[0-3][0-9]), (?<y>[0-9]{4})$/, # month word dd, yyyy
    /^(?<m>[A-Z][a-z]{2}) (?<d>[0-3][0-9]), (?<y>[0-9]{2})$/  # month word dd, yy
  ]
  MONTHS = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]

  private_constant :REGEXES, :MONTHS

  # Return date as yyyy-mm-dd
  def self.fix_date(date)
    REGEXES.each do |r|
      match = r.match(date)
      return format("%04d-%02d-%02d", format_year(match['y']), format_month(match['m']), match['d'].to_i) if match
    end
    "Error! Date format not recognised"
  end

  # Private

  # n.b. private keyword doesn't work on explicit objects such as self so we use private_class_method instead

  def self.format_year(year)
    year = year.to_i
    year += 2000 if year < 50
    year += 1900 if year < 100
    year
  end

  def self.format_month(month)
    month = (MONTHS.index(month) + 1) if MONTHS.include? month
    month.to_i
  end

  private_class_method :format_year, :format_month

end
