class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if authenticate_user
      login_user
      redirect_to user_url(user)
    else
      flash[:error] = 'Incorrect email or password, try again.'
      render 'new'
    end
  end

  def destroy
    logout_user

    redirect_to root_path
  end

  private

  attr_reader :user

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def authenticate_user
    AuthenticateUser.call(user: user, password: session_params[:password])
  end

  def login_user
    session[:user_id] = user.id.to_s
  end

  def logout_user
    session.delete(:user_id)
  end
end
