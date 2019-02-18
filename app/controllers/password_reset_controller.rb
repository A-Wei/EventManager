class PasswordResetController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :validate_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def show
  end

  def new
  end

  def edit
  end

  def create
    user = User.find_by(email: email_params)

    if user
      user.create_password_reset_digest
      UserMailer.password_reset(user).deliver_now
    end

    render 'show'
  end

  def update
    if Password.new(user_params).valid?
      @user.update_attributes(user_params)
      flash[:success] = 'Password has been reset.'
      redirect_to login_path
    else
      flash[:error] = 'Invalid password, minimum 6 characters and password confirmation must match'
      redirect_to request.referrer
    end
  end

  private

  def email_params
    params[:password_reset][:email]
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def validate_user
    if !(@user && @user.authenticated?(@user.password_reset_digest, params[:id]))
      redirect_to login_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:error] = 'Password reset has expired.'
      redirect_to new_password_reset_url
    end
  end
end
