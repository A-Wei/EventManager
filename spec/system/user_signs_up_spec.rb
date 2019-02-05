require 'rails_helper'

RSpec.describe "User signs up", type: :system do
  context 'when the sign up data is valid' do
    it 'allows guest to create an user' do
      visit '/signup'

      fill_in 'name', with: 'Test User'
      fill_in 'email', with: 'test@user.com'
      fill_in 'password', with: '123456'
      fill_in 'password_confirmation', with: '123456'
      click_button 'sign_up'

      expect(page).to have_text('Hello Test User, Welcome to EventManager')
    end
  end

  context 'when the sign up data is invalid' do
    it "shows 'name can't be blank' message when the name is not given" do
      visit '/signup'

      fill_in 'email', with: 'test@user.com'
      fill_in 'password', with: '123456'
      fill_in 'password_confirmation', with: '123456'
      click_button 'sign_up'

      expect(page).to have_text("Name can't be blank")
    end

    it "shows 'email can not be blank' message when the email is not given" do
      visit '/signup'

      fill_in 'name', with: 'Test User'
      fill_in 'password', with: '123456'
      fill_in 'password_confirmation', with: '123456'
      click_button 'sign_up'

      expect(page).to have_text("Email can't be blank")
    end

    it "shows 'email is invalid' message when the email is incorrect" do
      visit '/signup'

      fill_in 'name', with: 'Test User'
      fill_in 'email', with: 'test@usercom'
      fill_in 'password', with: '123456'
      fill_in 'password_confirmation', with: '123456'
      click_button 'sign_up'

      expect(page).to have_text('Email is invalid')
    end

    it "shows 'password is invalid, minimum 6 characters' message when password is too short" do
      visit '/signup'

      fill_in 'name', with: 'Test User'
      fill_in 'email', with: 'test@usercom'
      fill_in 'password', with: '12345'
      fill_in 'password_confirmation', with: '12345'
      click_button 'sign_up'

      expect(page).to have_text('Password is too short (minimum is 6 characters)')
    end
  end
end
