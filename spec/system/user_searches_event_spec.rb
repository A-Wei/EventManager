require 'rails_helper'

RSpec.describe 'User searches events', type: :system do
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
