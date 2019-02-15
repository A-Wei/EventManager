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

  def update
    @user = User.find_by(email: params[:email])

    if @user.update_attributes(user_params)
      flash[:success] = 'Password has been reset.'
      redirect_to login_path
    else
      rendern 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
