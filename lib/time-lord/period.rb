module TimeLord
  class Period
    include Words

    attr_writer :beginning, :ending

    def initialize(beginning, ending)
      self.beginning = beginning
      self.ending = ending
    end

    def to_words
      value.zero? ? just_now : sprintf(tense, "#{value} #{unit}")
    end
    alias_method :in_words, :to_words

    def difference
      beginning - ending
    end
    alias_method :to_i, :difference

    def to_time
      if difference < 0 then @beginning else @ending end
    end

    def to_range
      beginning..ending
    end

    def beginning
      @beginning.to_i
    end

    def ending
      @ending.to_i
    end

    private

    def value
      Scale.new(absolute).to_value
    end

    def unit
      Scale.new(absolute).to_unit
    end

    def absolute
      difference.abs
    end

    def tense
      if difference <= 0 then past else future end
    end
  end
end
