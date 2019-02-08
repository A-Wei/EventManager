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
end

RSpec.configure do |config|
  config.include AuthHelper, type: :system
end
