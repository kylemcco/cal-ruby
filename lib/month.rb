require_relative 'year'
require_relative 'day'

class Month
  attr_reader :day, :month, :year
  ZELLERS_ARR  = (0..6).to_a


  def initialize(month, year)
    @month        = month
    @year         = year
    @day          = Day.new(@month, @year).start_day
    @month_header = "#{"#{name} #{year}".center(20).rstrip}"
  end

  def name
    months = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"]
    months[@month - 1]
  end

  def days_in_month
    case @month
    when 1, 3, 5, 7, 8, 10, 12
      31
    when 4, 6, 9, 11
      30
    else
      Year.new(@year).leap
    end
  end

  def line1_whitespace
    "\s" * (18 - (ZELLERS_ARR.reverse[@day - 1] * 3))
  end

  def new_line?(day)
    (day + ZELLERS_ARR[@day]).modulo(7).zero?
  end

  def each_day
    output = line1_whitespace
    (days_in_month - 1).times do |day|
      new_line?(day) ? output << "#{day + 1}\n".rjust(3) : output << "#{day + 1}\s".rjust(3)
    end
    output << "#{days_in_month.to_s}\n"
  end

  def days
    day_output = "Su Mo Tu We Th Fr Sa\n"
    day_output << each_day
  end

  def to_s
    <<EOS
#{@month_header}
#{days}
EOS
  end

end
