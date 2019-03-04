require 'rails_helper'

RSpec.describe 'User searches', type: :system do
  context 'when user searches for events' do
    it 'returns all events, past and future, ' \
      'where title, location or description matches the search term' do
      travel_to Time.new(2019, 2, 2, 10) do
        create(:event, location: 'Unique location')
        create(:event, description: 'Unique description')
      end
      create(:event, title: 'Unique Event')
      create(:event, title: 'New Event')

      visit events_path
      fill_in 'Term', with: 'Unique'
      click_button 'Submit'

      expect(page).to have_text('Unique location')
      expect(page).to have_text('Unique description')
      expect(page).to have_text('Unique Event')
      expect(page).not_to have_text('New Event')
    end
  end

  context 'when the user searches for users' do
    it 'returns all users where name or email address matches the search term' do
      create(:user, name: 'Calvin')
      create(:user, email: 'calvin@example.com')
      create(:user, email: 'bob@example.com')

      visit events_path
      fill_in 'Term', with: 'Calvin'
      click_button 'Submit'

      expect(page).to have_text('Calvin')
      expect(page).to have_text('calvin@example.com')
      expect(page).not_to have_text('bob@example.com')
    end
  end

  context 'when the user searches for both events and users' do
    it 'returns the events and users where the search term matches ' \
      "event's title/location/description or user's name or email" do
      create(:event, title: "Alice's birthday")
      create(:user, name: 'Alice')
      create(:event, title: "Bob's birthday")
      create(:user, name: 'Bob', email: 'bob@example.com')

      visit events_path
      fill_in 'Term', with: 'Bob'
      click_button 'Submit'

      expect(page).to have_text("Bob's birthday")
      expect(page).to have_text('bob@example.com')
      expect(page).not_to have_text('Alice')
    end
  end
end
