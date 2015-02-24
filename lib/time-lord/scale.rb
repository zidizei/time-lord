module TimeLord
  class Scale
    include Units
    include Words

    attr_accessor :absolute

    def initialize(absolute)
      self.absolute = absolute
    end

    def to_value
      timemap.first
    end

    def to_unit
      timemap.last
    end

    private

    def timemap
      case absolute
      when 0               then as(SECOND, :second)
      when SECOND...MINUTE then as(SECOND, :second)
      when MINUTE...HOUR   then as(MINUTE, :minute)
      when HOUR...DAY      then as(HOUR, :hour)
      when DAY...WEEK      then as(DAY, :day)
      when WEEK...MONTH    then as(WEEK, :week)
      when MONTH...YEAR    then as(MONTH, :month)
      else                      as(YEAR, :year)
      end
    end

    def as(unit, word)
      self.absolute = count(unit)
      [self.absolute, self.send(word)]
    end

    def count(unit)
      absolute / unit
    end

    def pluralized_word(word, plural)
      word += "s" if plural
    end

    def plurality?(count)
      count > 1 || count.zero?
    end
  end
end
