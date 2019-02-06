class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user_url(user)
    else
      render 'new'
    end
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end
end
