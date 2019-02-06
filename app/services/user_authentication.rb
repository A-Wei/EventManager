class UserAuthentication
  def self.call(*args)
    new(*args).call
  end

  def initialize(user:, password:)
    @user = user
    @password = password
  end

  def call
    user && user.authenticate(password)
  end

  attr_reader :user, :password
end
