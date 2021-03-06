class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      render 'show'
    else
      render 'edit'
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])

    if @user != current_user
      flash[:error] = 'Not authorized.'
      redirect_to root_url
    end
  end
end
