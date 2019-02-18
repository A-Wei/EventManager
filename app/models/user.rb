class User < ApplicationRecord
  attr_accessor :password_reset_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  before_create { email.downcase! }

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  def logged_in?
    true
  end

  def create_password_reset_digest
    self.password_reset_token = Token.generate
    update_attribute(:password_reset_digest, digested_token)
    update_attribute(:password_reset_sent_at, Time.zone.now)
  end

  def authenticated?(digest, token)
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    password_reset_sent_at < 30.minutes.ago
  end

  def digested_token
    DigestToken.generate(string: password_reset_token)
  end
end
