require 'rails_helper'

RSpec.describe 'Use deletes an event', type: :system do
  context 'when user is the creator of the event' do
    context 'when the user clicks "Delete" button' do
      it 'deletes the event and redirects to event index page' do
        user = create(:user)
        event = create(:event, title: 'RSpec Test event', user: user)

        login(user)
        visit edit_event_path(event)
        click_button('Delete')

        expect(page).to have_text('RSpec Test event has been deleted')
        expect(page).to have_current_path(events_path)
      end
    end
  end
end
