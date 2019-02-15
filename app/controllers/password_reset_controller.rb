class PasswordResetController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])

    if @user
      @user.create_password_reset_digest
      @user.send_password_reset_email
    end

    render 'show'
  end

  def show
  end

  def edit
    @user = User.find_by(email: params[:email])
  end
end
