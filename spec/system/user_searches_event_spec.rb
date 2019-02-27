require 'rails_helper'

RSpec.describe 'User searches event', type: :system do
  context 'when user searches events by a given term' do
    it 'returns all events containing the given term in title' do
      travel_to Time.new(2019, 2, 2, 10) do
        create(:event, title: 'Test Event')
      end
      create(:event, title: 'Anohter Test')
      create(:event, title: 'Some Event')
      term = 'Test'

      visit events_path
      fill_in 'Search', with: term

      expect(page).to have_text('Test')
      expect(page).to have_text('Another Test')
      expect(page).not_to have_text('Some Event')
    end
  end
end
