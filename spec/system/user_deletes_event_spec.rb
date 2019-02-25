require 'rails_helper'

RSpec.describe 'Use deletes an event', type: :system do
  context 'when user is the creator of the event' do
    context 'when the user clicks "Delete" button' do
      it 'deletes the event and redirects to event index page' do
        user = create(:user)
        create(:event, title: 'Test event', user: user)

        login(user)
        visit events_path
        click_link('Delete')

        expect(page).to have_text('Test event has been deleted')
        expect(page).to have_current_path(events_path)
      end
    end
  end

  context 'when user is not the creator of the event' do
    it 'does not show "delete" button' do
      user = create(:user)
      create(:event, title: 'Test event')

      login(user)
      visit events_path

      expect(page).not_to have_link('Delete')
      expect(page).to have_current_path(events_path)
    end
  end
end
