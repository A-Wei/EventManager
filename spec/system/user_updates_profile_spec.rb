require 'rails_helper'

RSpec.describe 'User updates their profile', type: :system do
  context 'when the user is logged in' do
    context 'when they click the "Profile" button' do
      it 'saves changes made after submitting the form' do
        user = create(:user, name: 'Alice')

        login(user)
        click_link 'Profile'
        fill_in 'Name', with: 'Bob'
        fill_in 'Password', with: 'new_password', id: 'user_password'
        fill_in 'Password confirmation', with: 'new_password', id: 'user_password_confirmation'
        click_button 'Update'

        expect(page).to have_text('Bob')
      end

      it 'displays an error when password does not match' do
        user = create(:user)

        login(user)
        click_link 'Profile'
        fill_in 'Password', with: 'new_password', id: 'user_password'
        fill_in 'Password confirmation', with: 'old_password', id: 'user_password_confirmation'
        click_button 'Update'

        expect(page).to have_text("Password confirmation doesn't match")
      end
    end

    context "when visiting other user's profile page" do
      it 'redirects to root_path' do
        user1 = create(:user)
        user2 = create(:user)

        login(user1)
        visit edit_user_path(user2)

        expect(page).to have_text('Not authorized.')
        expect(page).to have_current_path(root_path)
      end
    end
  end

  context 'when user is not logged in' do
    it 'redirects to the login_path when trying to visit profile page' do
      user = create(:user)

      visit edit_user_path(user)

      expect(page).to have_text('Please log in.')
      expect(page).to have_current_path(login_path)
    end
  end
end
