require 'i18n'

module TimeLord
  def self.use_locale=(locale)
    @locale = locale
  end

  def self.use_locale?
    (@locale.nil?) ? true : @locale == true
  end

  module Words
    I18n.load_path         += [File.join(File.expand_path('../../..', __FILE__), 'locale', 'en.yml')]
    I18n.available_locales += [:en]

    [:second, :minute, :hour, :day, :week, :month, :year].each do |word|
      define_method(word) do
        if TimeLord.use_locale?
          begin
            I18n.t self.plurality, :scope => "time.#{word}", :raise => true
          rescue I18n::MissingTranslationData => e
            I18n.t word, :scope => "time"
          end
        else
          "#{pluralized_word(word.to_s, plurality?(self.absolute))}"
        end
      end
    end

    def just_now
      if TimeLord.use_locale?
        I18n.t 'just_now', :scope => "time"
      else
        'less than a second away'
      end
    end

    def past
      if TimeLord.use_locale?
        I18n.t 'past', :scope => "time"
      else
        '%s ago'
      end
    end

    def future
      if TimeLord.use_locale?
        I18n.t 'future', :scope => "time"
      else
        '%s from now'
      end
    end

    def pluralized_word(word, plural)
      word += "s" if plural
      word
    end

    def plurality
      (self.absolute > 1 || self.absolute.zero?) ? 'plural' : 'singular'
    end

    def plurality?(count)
      count > 1 || count.zero?
    end
  end
end
