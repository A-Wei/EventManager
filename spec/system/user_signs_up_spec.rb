require 'rails_helper'

RSpec.describe 'User signs up', type: :system do
  context 'when the sign up data is valid' do
    it 'allows guest to create an user' do
      visit '/signup'

      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: '123456', id: 'user_password'
      fill_in 'Password confirmation', with: '123456', id: 'user_password_confirmation'
      click_button 'Sign up'

      expect(page).to have_text('Hello Test User, Welcome to EventManager')
      expect(page).to have_xpath("//img[@class='gravatar']")
    end
  end

  context 'when the sign up data is invalid' do
    it "shows 'name can't be blank' message when the name is not given" do
      visit '/signup'

      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: '123456', id: 'user_password'
      fill_in 'Password confirmation', with: '123456', id: 'user_password_confirmation'
      click_button 'Sign up'

      expect(page).to have_text("Name can't be blank")
    end

    it "shows 'email can not be blank' message when the email is not given" do
      visit '/signup'

      fill_in 'Name', with: 'Test User'
      fill_in 'Password', with: '123456', id: 'user_password'
      fill_in 'Password confirmation', with: '123456', id: 'user_password_confirmation'
      click_button 'Sign up'

      expect(page).to have_text("Email can't be blank")
    end

    it "shows 'email is invalid' message when the email is incorrect" do
      visit '/signup'

      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test@example'
      fill_in 'Password', with: '123456', id: 'user_password'
      fill_in 'Password confirmation', with: '123456', id: 'user_password_confirmation'
      click_button 'Sign up'

      expect(page).to have_text('Email is invalid')
    end

    it "shows 'password is invalid, minimum 6 characters' message when password is too short" do
      visit '/signup'

      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: '12345', id: 'user_password'
      fill_in 'Password confirmation', with: '12345', id: 'user_password_confirmation'
      click_button 'Sign up'

      expect(page).to have_text('Password is too short (minimum is 6 characters)')
    end
  end

  context 'when a guest at /login page' do
    it "redirects to /signup after clicking the 'Sign up now' button" do
      visit '/login'
      click_link 'Sign up now'

      expect(page).to have_button('Sign up')
    end
  end
end
