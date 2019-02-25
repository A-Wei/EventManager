class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  private

  def current_user
    @_current_user ||= User.find_by_id(session[:user_id]) || Guest.new
  end

  def logged_in_user
    if !current_user.logged_in?
      flash[:error] = 'Please log in.'
      redirect_to login_url
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_to(events_path || root_path)
  end
  helper_method :current_user, :logged_in_user
end
