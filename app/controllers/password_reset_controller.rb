class PasswordResetController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :validate_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

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
  end

  def update
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

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def validate_user
    if !(@user && @user.authenticated?(@user.password_reset_digest, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:error] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end
