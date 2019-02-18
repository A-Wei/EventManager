class ValidateUser
  def self.call(*args)
    new(*args).call
  end

  def initialize(user:, id:)
    @user = user
    @id = id
  end

  def expired?
    user.reset_password_expired?
  end

  def not_authenticated?
    !(user && user.authenticated?(user.reset_password_digest, id))
  end

  private

  attr_reader :user, :id
end
