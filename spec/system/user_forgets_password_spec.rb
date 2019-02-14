require 'rails_helper'

RSpec.describe 'User resets their password', type: :system do
  context 'when clicks "forget password"' do
    context 'when the email exist and user opens reset password page' do
      it 'resets user password if the new password is valid and redirects to login page' do
        user = create(:user)
        new_password = 'new_password'

        forget_password(user.email)
        open_password_reset_page(user)
        reset_password(user)

        authenticated_user = user.authenticate(new_password)
        expect(authenticated_user).to eq(user)
        expect(page).to have_current_path(login_path)
      end

      it "show a 'password can't be blank' error if new password is blank" do
        user = create(:user)
        new_password = ''

        forget_password(user.email)
        open_password_reset_page(user)
        reset_password(new_password)

        expect(page).to to_have_text("Password can't be blank")
      end

      it "show a 'password too short' error if new password is too short" do
        user = create(:user)
        new_password = '12345'

        forget_password(user.email)
        open_password_reset_page(user)
        reset_password(new_password)

        expect(page).to to_have_text('Password is too short')
      end

      it "show a 'password doesn't math' error if passwords does't match" do
        user = create(:user)
        new_password = 'new_password'
      context 'when token and email does not match in the link' do
        it 'redirects to login page if token is incorrect' do
          user = create(:user)

          forget_password(user.email)
          open_password_reset_page(user, token: 'wrong_token')

          expect(page).to have_current_path(login_path)
        end

        it 'redirects to login page if email is incorrect' do
          user = create(:user)

        forget_password(user.email)
        open_password_reset_page(user)
        reset_password(password: new_password, password_confirmation: 'incorrect_password')
          forget_password(user.email)
          open_password_reset_page(user, email: 'wrong_email@example.com')

        expect(page).to to_have_text("Password confirmation doesn't match Password")
          expect(page).to have_current_path(login_path)
        end
      end
    end

    context 'when the email does not exist' do
      it "shows a 'user doesn't exist' error" do
        forget_password('incorrect@example.com')

        expect(page).to to_have_text("User doesn't exist")
      end
    end
  end
end
