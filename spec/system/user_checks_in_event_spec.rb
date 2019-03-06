require 'rails_helper'

RSpec.describe 'User checks in an event', type: :system do
  describe 'when user logged in and clicks check in button for an event' do
    it "register user as participant and show a 'check out' button" do
      user = create(:user)
      create(:event)

      login(user)
      visit events_path
      click_link('Check In')

      expect(page).to have_text('Check Out')
    end
  end
end
