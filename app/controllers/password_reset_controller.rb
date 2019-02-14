class PasswordResetController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])

    if @user
      @user.create_password_reset_digest
      render 'show'
    else
      flash[:error] = "User doesn't exist"
      render 'new'
    end
  end

  def show
  end
end
