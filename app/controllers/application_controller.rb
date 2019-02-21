class ApplicationController < ActionController::Base
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
  helper_method :current_user, :logged_in_user
end
