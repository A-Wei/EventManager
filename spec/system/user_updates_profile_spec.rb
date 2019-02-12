require 'rails_helper'

RSpec.describe 'User updates their profile', type: :system do
  context 'when the user is logged in' do
    context 'when they click the "Profile" button' do
      it 'saves changes made after submitting the form' do
        user = create(:user, name: 'Alice')

        login(user)
        click_link 'Profile'
        fill_in 'Name', with: 'Bob'
        click_button 'Update'

        expect(user.name).to eq('Bob')
      end
    end

    context "when visiting other user's profile page" do
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
      create(:user, id: 1)
    it 'redirects to the login_path when trying to visit profile page' do

      visit '/users/1/edit'

      expect(page).to have_current_path(login_path)
    end
  end
end
