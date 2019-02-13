require 'rails_helper'

RSpec.describe 'User resets their password', type: :system do
  context 'when clicks "forget password"' do
    context 'when the email exist and user opens reset password page' do
      it 'resets user password if the new password is valid and redirects to login page' do
        user = create(:user, email: 'alice@example.com')
        password = 'new_password'

        visit '/login'
        click_link 'forget password'
        fill_in 'Email', with: 'alice@example.com'
        click_button 'Submit'
        visit edit_password_reset_path(user.email)
        fill_in 'Password', with: password, id: 'user_password'
        fill_in 'Password confirmation', with: password, id: 'user_password_comfirmation'
        click_button 'Update'

        authentication = user.authenticate('new_password')
        expect(authentication).to eq(user)
        expect(page).to have_current_path(login_path)
      end

      it "show a 'password can't be blank' error if new password is blank" do
        user = create(:user, email: 'alice@example.com')
        password = ''

        visit '/login'
        click_link 'forget password'
        fill_in 'Email', with: 'alice@example.com'
        click_button 'Submit'
        visit edit_password_reset_path(user.email)
        fill_in 'Password', with: password, id: 'user_password'
        fill_in 'Password confirmation', with: password, id: 'user_password_comfirmation'
        click_button 'Update'

        expect(page).to to_have_text("Password can't be blank")
      end

      it "show a 'password too short' error if new password is too short" do
        user = create(:user, email: 'alice@example.com')
        password = '12345'

        visit '/login'
        click_link 'forget password'
        fill_in 'Email', with: 'alice@example.com'
        click_button 'Submit'
        visit edit_password_reset_path(user.email)
        fill_in 'Password', with: password, id: 'user_password'
        fill_in 'Password confirmation', with: password, id: 'user_password_comfirmation'
        click_button 'Update'

        expect(page).to to_have_text('Password is too short')
      end

      it "show a 'password doesn't math' error if passwords does't match" do
        user = create(:user, email: 'alice@example.com')
        password = '12345'

        visit '/login'
        click_link 'forget password'
        fill_in 'Email', with: 'alice@example.com'
        click_button 'Submit'
        visit edit_password_reset_path(user.email)
        fill_in 'Password', with: password, id: 'user_password'
        fill_in 'Password confirmation', with: password, id: 'user_password_comfirmation'
        click_button 'Update'

        expect(page).to to_have_text("Password confirmation doesn't match Password")
      end
    end

    context 'when the email does not exist' do
      it "shows a 'user doesn't exist' error" do
        visit '/login'
        click_link 'forget password'
        fill_in 'Email', with: 'new_user@example.com'
        click_button 'Submit'

        expect(page).to to_have_text("User doesn't exist")
      end
    end
  end
end
