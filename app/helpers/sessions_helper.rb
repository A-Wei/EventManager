module SessionsHelper
  def current_user
    if session[:user_id]
      @_current_user ||= User.find(session[:user_id])
    end
  end
end
