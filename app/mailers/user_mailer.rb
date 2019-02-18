class UserMailer < ApplicationMailer
  def reset_password(user)
    @user = user
    mail to: user.email, subject: 'Password reset'
  end
end
