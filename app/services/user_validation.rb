class UserValidation
  def self.validate(*args)
    new(*args).validate
  end

  def initialize(user:, password:)
    @user = user
    @password = password
  end

  def validate
    user && user.authenticate(password)
  end

  attr_reader :user, :password
end
