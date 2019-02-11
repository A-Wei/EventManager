class UsersController < ApplicationController
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
end
