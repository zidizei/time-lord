require 'i18n'

module TimeLord
  def self.locale=(locale)
    @locale = locale
    I18n.available_locales += [locale]
  end

  def self.locale
    @locale || :en
  end

  module Words
    I18n.load_path         += [File.join(File.expand_path('../../..', __FILE__), 'locale', 'en.yml')]
    I18n.available_locales += [:en]

    [:second, :minute, :hour, :day, :week, :month, :year].each do |word|
      define_method(word) do
        I18n.locale = TimeLord.locale
        begin
          I18n.t self.plurality, :scope => "time.#{word}", :raise => true
        rescue I18n::MissingTranslationData => e
          I18n.t word, :scope => "time"
        end
      end
    end

    def just_now
      I18n.t 'just_now', :scope => "time"
    end

    def past
      I18n.t 'past', :scope => "time"
    end

    def future
      I18n.t 'future', :scope => "time"
    end

    def plurality
      (self.absolute > 1 || self.absolute.zero?) ? 'plural' : 'singular'
    end
  end
end
