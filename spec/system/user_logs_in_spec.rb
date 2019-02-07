require 'rails_helper'

RSpec.describe 'User logs in', type: :system do
  context 'when the login data is valid' do
    it 'allows the user to login and redirect to welcome page' do
      create(
        :user,
        name: 'Bob',
        email: 'bob@example.com',
        password: 'foobar',
        password_confirmation: 'foobar'
      )

      visit '/login'
      fill_in 'Email', with: 'bob@example.com'
      fill_in 'Password', with: 'foobar'
      click_button 'Log in'

      expect(page).to have_text('Hello Bob, Welcome to EventManager')
    end
  end

  context 'when the login data is incorrect' do
    it "shows 'Incorrect email or password, try again.' when email is incorrect" do
      create(
        :user,
        name: 'Bob',
        email: 'bob@example.com',
        password: 'foobar',
        password_confirmation: 'foobar'
      )

      visit '/login'
      fill_in 'Email', with: 'test_user@example.com'
      fill_in 'Password', with: 'foobar'
      click_button 'Log in'

      expect(page).to have_text('Incorrect email or password, try again.')
    end

    it "shows 'Incorrect email or password, try again.' when password is incorrect" do
      create(
        :user,
        name: 'Bob',
        email: 'bob@example.com',
        password: 'foobar',
        password_confirmation: 'foobar'
      )

      visit '/login'
      fill_in 'Email', with: 'bob@example.com'
      fill_in 'Password', with: 'incorrect_password'
      click_button 'Log in'

      expect(page).to have_text('Incorrect email or password, try again.')
    end
  end
end
