module SessionsHelper
  def session_params
    params.require(:session).permit(:email, :password)
  end

  def user_validation(user)
    user && user.authenticate(session_params[:password])
  end
end
