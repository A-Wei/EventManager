class Password
  include ActiveModel::Model

  validates(
    :password,
    :password_confirmation,
    presence: true,
    length: { minimum: 6 },
    confirmation: true,
  )

  attr_accessor :password, :password_confirmation
end
