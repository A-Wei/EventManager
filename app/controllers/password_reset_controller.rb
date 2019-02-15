class PasswordResetController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])

    if @user
      @user.create_password_reset_digest
    end

    render 'show'
  end

  def show
  end
end
