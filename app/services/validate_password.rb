class ValidatePassword
  def self.call(*arg)
    new(*arg).call
  end

  def initialize(params)
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end

  def call
    present_password? && long_password? && match_password?
  end

  def present_password?
    password.present?
  end

  def long_password?
    password.length > 6
  end

  def match_password?
    password == password_confirmation
  end

  attr_reader :password, :password_confirmation
end
