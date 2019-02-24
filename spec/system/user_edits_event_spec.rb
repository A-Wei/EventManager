require 'rails_helper'

RSpec.describe 'User edits an event', type: :system do
  context 'when user is the creator of the event' do
    context 'when update data is correct' do
      it 'saves the change and redirects to show page' do
        user = create(:user)
        event = create(:event, user: user)

        login(user)
        visit edit_event_path(event)
        fill_in 'Title', with: 'New title'
        click_button 'Update'

        event.reload
        expect(event.title).to eq('New title')
        expect(page).to have_current_path(events_path)
      end
    end

    context ' when update data is incorrect' do
      it "shows 'Title can't be blank' error and rerender the page" do
        user = create(:user)
        event = create(:event, user: user)

        login(user)
        visit edit_event_path(event)
        fill_in 'Title', with: ''
        click_button 'Update'

        expect(page).to have_current_path(edit_event_path(event))
        expect(page).to have_text("Title can't be blank")
      end

      it "shows 'Location can't be blank' error and rerender the page" do
        user = create(:user)
        event = create(:event, user: user)

        login(user)
        visit edit_event_path(event)
        fill_in 'Location', with: ''
        click_button 'Update'

        expect(page).to have_current_path(edit_event_path(event))
        expect(page).to have_text("Location can't be blank")
      end

      it "shows 'Description can't be blank' error and rerender the page" do
        user = create(:user)
        event = create(:event, user: user)

        login(user)
        visit edit_event_path(event)
        fill_in 'Description', with: ''
        click_button 'Update'

        expect(page).to have_current_path(edit_event_path(event))
        expect(page).to have_text("Description can't be blank")
      end

      it "shows 'Start at can't be in the past' error if Start at earlier than current time" do
        user = create(:user)
        event = create(:event, user: user)

        login(user)
        visit edit_event_path(event)
        fill_in 'Start at', with: 1.hour.ago
        click_button 'Update'

        expect(page).to have_current_path(edit_event_path(event))
        expect(page).to have_text("Start at can't be in the past")
      end

      it "shows 'End at can't be earlier then Start at' error" do
        user = create(:user)
        event = create(:event, user: user)

        login(user)
        visit edit_event_path(event)
        fill_in 'Start at', with: 2.hours.from_now
        fill_in 'End at', with: 1.hour.from_now
        click_button 'Update'

        expect(page).to have_current_path(edit_event_path(event))
        expect(page).to have_text("End at can't be earlier then start at")
      end
    end
  end

  context 'when user is not the creator of the event' do
    it 'redirects to create event index page' do
      event = create(:event)

      visit edit_event_path(event)

      expect(page).to have_text('Sorry, you are not authorized to modify this event')
      expect(page).to have_current_path(events_path)
    end
  end
end
