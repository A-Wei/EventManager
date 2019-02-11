module SessionsHelper
  def current_user
    @_current_user ||= User.find_by_id(session[:user_id]) || Guest.new
  end
end
