class Token
  include ActionView::Helpers::DateHelper

  def self.generate(*args)
    new(*args).generate
  end

  def generate
    SecureRandom.urlsafe_base64
  end

  def token_valids_for_in_words
    time_ago_in_words(valid_time.minutes.from_now)
  end

  def valid_time
    30
  end
end
