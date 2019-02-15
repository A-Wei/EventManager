module AuthHelper
  def login(user)
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def logout
    click_link 'Log out'
  end

  def forget_password(email)
    visit '/login'
    click_link 'forget password'
    fill_in 'Email', with: email
    click_button 'Submit'
  end

  def reset_password(password, password_confirmation = password)
    fill_in 'Password', with: password, id: 'user_password'
    fill_in 'Password confirmation', with: password_confirmation, id: 'user_password_confirmation'
    click_button 'Update'
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :system
end
