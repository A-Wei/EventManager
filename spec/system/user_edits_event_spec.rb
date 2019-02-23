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
