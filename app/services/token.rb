class Token
  def self.generate(*args)
    new(*args).generate
  end

  def generate
    SecureRandom.urlsafe_base64
  end
end
