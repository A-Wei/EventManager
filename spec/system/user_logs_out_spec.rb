require 'rails_helper'

RSpec.describe 'User logs out', type: :system do
  context "when logged in user clicks 'Log Out'" do
    it 'logs out the user and redirect to root_path' do
      user = create(:user)

      login(user)
      logout

      expect(page).to have_current_path(root_path)
    end
  end
end
