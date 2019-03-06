require 'rails_helper'

RSpec.describe 'User checks in an event', type: :system do
  describe 'when user logged in' do
    context "when clicking 'check in' link for an event" do
      it "registers the user as participant and show a 'check out' link instead" do
        user = create(:user)
        create(:event)

        login(user)
        visit events_path
        click_link('Check In')

        expect(page).to have_text('Check Out')
      end
    end

    context "when clicking 'check out' link for an event" do
      it "deregisters the user as participant and show a 'check in' link instead" do
        user = create(:user)
        create(:event)

        login(user)
        visit events_path
        click_link('Check In')
        click_link('Check Out')

        expect(page).to have_text('Check In')
      end
    end
  end
end
