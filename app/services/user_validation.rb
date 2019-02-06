class UserValidation
  def validate(user, password)
    user && user.authenticate(password)
  end
end
