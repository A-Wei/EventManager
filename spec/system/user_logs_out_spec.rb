require 'rails_helper'

RSpec.describe 'User logs out', type: :system do
  it "redirects to root_path if user clicks 'Log out'" do
    user = create(:user)

    login(user)
    logout

    expect(page).to have_current_path(root_path)
    expect(page).to have_text('Sign up')
  end
end
