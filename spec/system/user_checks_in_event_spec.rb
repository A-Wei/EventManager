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
      it "updates the checked_out_at time and show 'Participated' link" do
        user = create(:user)
        event = create(:event)

        login(user)
        visit events_path
        click_link('Check In')
        click_link('Check Out')

        expect(page).to have_text('Participated')
      end
    end

    context "when clicking 'Participated' link for an event" do
      it 'redirects to the event show page' do
        user = create(:user)
        event = create(:event)

        login(user)
        visit events_path
        click_link('Check In')
        click_link('Check Out')
        click_link('Participated')

        expect(page).to have_current_path(event_path(event))
      end
    end
  end

  describe 'when user not logged in' do
    it "redirects to login page when click 'Check In' link" do
      create(:event)

      visit events_path
      click_link('Check In')

      expect(page).to have_current_path(login_path)
    end
  end
end
