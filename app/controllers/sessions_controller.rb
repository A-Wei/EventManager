class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user_validation(user)
      redirect_to user_url(user)
    else
      flash[:error] = "Incorrect email or password, try again."
      render 'new'
    end
  end
end
