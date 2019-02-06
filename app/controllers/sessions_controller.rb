class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if validate_user
      redirect_to user_url(user)
    else
      flash[:error] = "Incorrect email or password, try again."
      render 'new'
    end
  end

  private

  attr_reader :user

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def validate_user
    UserValidation.new.validate(user, session_params[:password] )
  end
end
