
class BoxPlot

  def initialize(data)
    @data = data.clone.sort
  end

  def quartile(num)
    @data[quartile_index(num)]
  end

  def quartile_index(num)
    (num * @data.length / 4).ceil
  end

  def iqr
    quartile(3) - quartile(1)
  end

  def outlier?(num)
    num < whiskers[:left] || num > whiskers[:right]
  end

  def whiskers
    {left: (quartile(1) - iqr * 1.5), right: (quartile(3) + iqr * 1.5)}
  end

  def outliers
    @data.select{ |x| outlier? x }
  end

  def range
    @data.last - @data.first
  end

  def section(value)
    if value < whiskers[:left]
        :l_outlier
      elsif value < quartile(1)
        :l_whisker
      elsif value < quartile(2)
        :l_iqr
      elsif value < quartile(3)
        :r_iqr
      elsif value < whiskers[:right]
        :r_whisker
      else
        :r_outlier
    end
  end

  def draw
    processed = @data.inject({}){ |h, v| h[v] = section(v); h }
    width = 80
    values_per_index = range.to_f / width
    out_line = Array.new(width, " ")
    out_line.each_with_index do |v, i|
      lb, ub = @data.first + i * values_per_index, @data.first + (i + 1) * values_per_index
      data_covered = processed.select{ |k, _| (lb..ub).include? k }
      out_line[i] = if data_covered.empty?
        case section((ub + lb) / 2)
        when :l_outlier then " "
        when :r_outlier then " "
        when :l_whisker then "-"
        when :r_whisker then "-"
        when :l_iqr then "="
        when :r_iqr then "="
        end
        if (section(lb) == :l_iqr || section(lb) == :l_whisker || section(lb) == :l_outlier) &&
           (section(ub) == :r_iqr || section(ub) == :r_whisker || section(ub) == :r_outlier)
          out_line[i] = "|"
        end

      else
        if data_covered.values.include? :l_outlier then "x"
        elsif data_covered.values.include? :r_outlier then "x"
        elsif data_covered.values.include? :l_whisker then "-"
        elsif data_covered.values.include? :r_whisker then "-"
        elsif data_covered.values.include?(:l_iqr) && data_covered.values.include?(:r_iqr) then "|"
        elsif data_covered.values.include? :l_iqr then "="
        elsif data_covered.values.include? :r_iqr then "="
        else " "
        end
      end
    end
    puts @data.first.to_s.ljust((width/2).ceil) + @data.last.to_s.rjust((width/2).floor), out_line.join
  end

end

#input = "7 12 21 28 28 29 30 32 34 35 35 36 38 39 40 40 42 44 45 46 47 49 50 53 55 56 59 63 80 191"
input =
  "2095 2180 1049 1224 1350 1567 1477 1598 1462  972 1198 1847
  2318 1460 1847 1600  932 1021 1441 1533 1344 1943 1617  978
  1251 1157 1454 1446 2182 1707 1105 1129 1222 1869 1430 1529
  1497 1041 1118 1340 1448 1300 1483 1488 1177 1262 1404 1514
  1495 2121 1619 1081  962 2319 1891 1169"
data = input.split.map{ |x| x.to_i }
plot = BoxPlot.new(data)
plot.draw()