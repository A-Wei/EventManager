require 'rails_helper'

RSpec.describe 'User checks in and out from an event', type: :system do
  describe 'when user logged in' do
    context "when clicking 'check in' link for an event" do
      it "registers the user as attendants and show 'check out' when registration successful" do
        user = create(:user)
        event = create(:event)

        login(user)
        visit events_path
        click_link('Check In')

        expect(page).to have_text('Check Out')
        expect(page).to have_text("You have checked in #{event.title}")
      end

      it "shows 'user already checked in' when they have checked in before'" do
        user = create(:user)
        event = create(:event)
        create(:event_attendant, event: event, user: user, checked_out_at: nil)

        login(user)
        page.driver.follow(:post, check_in_event_path(event))

        expect(page).to have_text('Check Out')
        expect(page).to have_text('User already checked in')
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
        expect(page).to have_text("You have checked out #{event.title}")
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
