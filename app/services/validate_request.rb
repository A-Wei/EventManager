class ValidateRequest
  # include ActionController::UrlFor
  # include ActionDispatch::Flash::RequestMethods
  # include Rails.application.routes.url_helpers

  def self.call(*args)
    new(*args).call
  end

  def initialize(user:, id:)
    @user = user
    @id = id
  end

  def call
    validate_user
    check_expiration
  end

  attr_reader :user, :id

  private

  def validate_user
    if !(user && user.authenticated?(user.reset_password_digest, id))
      redirect_to login_path
    end
  end

  def check_expiration
    if user.reset_password_expired?
      flash[:error] = 'Password reset has expired.'
      redirect_to new_reset_password_url
    end
  end
end
