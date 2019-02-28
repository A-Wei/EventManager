class User < ApplicationRecord
  include PgSearch
  attr_accessor :reset_password_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  before_create { email.downcase! }

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  has_many :events

  pg_search_scope :search, against: [:name, :email],
                           using: {
                             tsearch: {
                               any_word: true,
                               dictionary: 'english',
                               normalization: 8,
                             },
                             trigram: {
                               threshold: 0.2,
                             },
                           }

  def logged_in?
    true
  end

  def create_reset_password_digest
    self.reset_password_token = Token.generate
    update_column(:reset_password_digest, digested_token)
    update_column(:reset_password_sent_at, Time.zone.now)
  end

  def authenticated?(digest, token)
    BCrypt::Password.new(digest).is_password?(token)
  end

  def reset_password_expired?
    token_expires_at > reset_password_sent_at
  end

  private

  def digested_token
    DigestToken.generate(string: reset_password_token)
  end

  def token_expires_at
    Token.new.valid_time.minutes.ago
  end
end
