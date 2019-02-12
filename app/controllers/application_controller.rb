class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @_current_user ||= User.find_by_id(session[:user_id]) || Guest.new
  end
  helper_method :current_user
end
