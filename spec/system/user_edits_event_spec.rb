require 'rails_helper'

RSpec.describe 'User edits an event' do
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
      end
    end
  end
end
