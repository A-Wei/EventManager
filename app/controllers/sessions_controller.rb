class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      redirect_to user_url(user)
    else
      flash[:error] = "Incorrect email or password, try again."
      render 'new'
    end
  end
end
