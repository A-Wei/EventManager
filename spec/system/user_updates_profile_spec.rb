require 'rails_helper'

RSpec.describe 'User updates profile', type: :system do
  context 'when user is logged in' do
    context 'and visit his/her own profile page' do
      it 'shows a form and save changes made after click the update button' do
        user = create(:user, name: 'Alice')

        login(user)
        click_link 'Profile'
        fill_in 'Name', with: 'Bob'
        click_button 'Update'

        expect(user.name).to eq('Bob')
      end
    end

    context "and visit other user's profile page" do
      it 'redirects to root_path' do
        user1 = create(:user, id: 1)
        create(:user, id: 2)

        login(user1)
        visit '/users/2/edit'

        expect(page).to have_current_path(root_path)
      end
    end
  end

  context 'when user is not logged in' do
    it 'redirects to log in when try to visit profile page' do
      create(:user, id: 1)

      visit '/users/1/edit'

      expect(page).to have_current_path(login_path)
    end
  end
end
