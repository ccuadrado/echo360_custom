require 'time.rb'

class IsoDate
  include Comparable
  
  attr_reader :date
  
  def initialize(date = Time.new)
    if(Time === date)
      @date = date
    elsif (String === date)
      @date = Time.parse(date)
    else
      #garbage input defaults this IsoDate to now
      @date = Time.new
    end
  end
  
  #----Overriden methods----#
  def <=>(other)
    if self.date < other.date
      -1
    elsif self.date > other.date
      1
    else
      0
    end
  end
  
  def inspect
    date.inspect
  end
  #----End Overriden methods----#
end