require 'rails_helper'

RSpec.describe 'User searches', type: :system do
  context 'when user searches for events' do
    it 'returns all events, past and future, where the title matches the search term' do
      travel_to Time.new(2019, 2, 2, 10) do
        create(:event, title: 'Test Event')
      end
      create(:event, title: 'Another Test')
      create(:event, title: 'Some Event')

      visit events_path
      fill_in 'Term', with: 'Test'
      click_button 'Submit'

      expect(page).to have_text('Test Event')
      expect(page).to have_text('Another Test')
      expect(page).not_to have_text('Some Event')
    end
  end

  context 'when the user searches for users' do
    it 'returns all users where the email address matches the search term' do
      create(:user, email: 'alice@example.com')
      create(:user, email: 'bob@example.com')

      visit events_path
      fill_in 'Term', with: 'Alice'
      click_button 'Submit'

      expect(page).to have_text('alice@example.com')
      expect(page).not_to have_text('bob@example.com')
    end
  end

  context 'when the user searches for both events and users' do
    it 'returns the events and users where the search term matches the title and email' do
      create(:event, title: "Alice's birthday")
      create(:user, email: 'alice@example.com')
      create(:event, title: "Bob's birthday")
      create(:user, email: 'bob@example.com')

      visit events_path
      fill_in 'Term', with: 'Bob'
      click_button 'Submit'

      expect(page).to have_text("Bob's birthday")
      expect(page).to have_text("bob@example.com")
    end
  end
end
