require 'rails_helper'

RSpec.describe 'User resets their password', type: :system do
  context 'when token and email address are correct in the url' do
    it 'resets user password and redirects to login page if the new password is valid' do
      user = create(:user)
      new_password = 'new_password'
      token = 'user_reset_token'
      allow(User).to receive(:new_token).and_return(token)

      forget_password(user.email)
      visit edit_password_reset_path(token, email: user.email)
      reset_password(new_password)
      user.reload

      authenticated_user = user.authenticate(new_password)
      expect(authenticated_user).to eq(user)
      expect(page).to have_current_path(login_path)
    end

    it "shows 'Password reset has expired.' and redirects to new_password_reset_path" do
      user = create(:user)
      token = 'user_reset_token'
      allow(User).to receive(:new_token).and_return(token)

      travel_to(1.hour.ago) do
        forget_password(user.email)
      end
      visit edit_password_reset_path(token, email: user.email)

      expect(page).to have_current_path(new_password_reset_path)
      expect(page).to have_text('Password reset has expired.')
    end

    context 'when the new password is incorrect' do
      it "show a 'password can't be blank' error" do
        user = create(:user)
        new_password = ''
        token = 'user_reset_token'
        allow(User).to receive(:new_token).and_return(token)

        forget_password(user.email)
        visit edit_password_reset_path(token, email: user.email)
        reset_password(new_password)

        expect(page).to have_text('Invalid password')
        expect(page).to have_text('Reset Password')
      end

      it "show a 'password too short' error" do
        user = create(:user)
        new_password = '12345'
        token = 'user_reset_token'
        allow(User).to receive(:new_token).and_return(token)

        forget_password(user.email)
        visit edit_password_reset_path(token, email: user.email)
        reset_password(new_password)

        expect(page).to have_text('Invalid password')
        expect(page).to have_text('Reset Password')
      end

      it "show a 'password doesn't math' error" do
        user = create(:user)
        new_password = '123456'
        token = 'user_reset_token'
        allow(User).to receive(:new_token).and_return(token)

        forget_password(user.email)
        visit edit_password_reset_path(token, email: user.email)
        reset_password(new_password, 'incorrect_password')

        expect(page).to have_text('Invalid password')
        expect(page).to have_text('Reset Password')
      end
    end
  end

  context 'when token or email address is incorrect in the url' do
    it 'redirects to login page if token is incorrect' do
      user = create(:user)
      token = 'user_reset_token'
      wrong_token = 'wrong_token'
      allow(User).to receive(:new_token).and_return(token)

      forget_password(user.email)
      visit edit_password_reset_path(wrong_token, email: user.email)

      expect(page).to have_current_path(login_path)
    end

    it 'redirects to login page if email is incorrect' do
      user = create(:user)
      token = 'user_reset_token'
      wrong_email = 'incorrect@example.com'
      allow(User).to receive(:new_token).and_return(token)

      forget_password(user.email)
      visit edit_password_reset_path(token, email: wrong_email)

      expect(page).to have_current_path(login_path)
    end
  end
end
