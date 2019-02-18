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
    self.password_reset_token = User.new_token
    update_attribute(:password_reset_digest, User.digest(password_reset_token))
    update_attribute(:password_reset_sent_at, Time.zone.now)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(digest, token)
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    password_reset_sent_at < 30.minutes.ago
  end
end
