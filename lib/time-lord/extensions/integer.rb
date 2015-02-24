class Integer
  TimeLord::Units.constants.each do |constant|
    define_method constant.downcase do
      self * TimeLord::Units.const_get(constant)
    end
    alias_method "#{constant.downcase}s", constant.downcase
  end

  def ago
    TimeLord::Time.new(Time.now - self).period
  end

  def from_now
    TimeLord::Time.new(Time.now + self).period
  end

  def from(other)
    TimeLord::Time.new(other + self).period
  end

  def to(other)
    TimeLord::Time.new(other - self).period
  end
end
