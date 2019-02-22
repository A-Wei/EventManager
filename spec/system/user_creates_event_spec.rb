require 'rails_helper'

RSpec.describe 'User creates event', type: :system do
  context 'when logged in user clicks "create event" button on home page' do
    context 'when event data is correct' do
      it 'creates an event and redirect to event show page' do
        user = create(:user)
        start_at = 1.hour.from_now
        end_at = 2.hours.from_now

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start at', with: start_at
        fill_in 'End at', with: end_at
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        event = Event.last
        expect(page).to have_current_path(event_path(event))
        expect(page).to have_text('Test event')
      end
    end

    context 'when event data is inccorect' do
      it "shows 'Title can't be blank' error and rerender the page" do
        user = create(:user)
        start_at = 1.hour.from_now
        end_at = 2.hours.from_now

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Start at', with: start_at
        fill_in 'End at', with: end_at
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Title can't be blank")
      end

      it "shows 'Location can't be blank' error and rerender the page" do
        user = create(:user)
        start_at = 1.hour.from_now
        end_at = 2.hours.from_now

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start at', with: start_at
        fill_in 'End at', with: end_at
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Location can't be blank")
      end

      it "shows 'Description can't be blank' error and rerender the page" do
        user = create(:user)
        start_at = 1.hour.from_now
        end_at = 2.hours.from_now

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start at', with: start_at
        fill_in 'End at', with: end_at
        fill_in 'Location', with: 'Online'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Description can't be blank")
      end

      it "shows 'Start at can't be in the past' error if Start at earlier than current time" do
        user = create(:user)
        start_at = 2.hours.ago
        end_at = 1.hour.ago

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start at', with: start_at
        fill_in 'End at', with: end_at
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Start at can't be in the past")
      end

      it "shows 'End at can't be earlier then Start at' error" do
        user = create(:user)
        start_at = 2.hours.from_now
        end_at = 1.hour.from_now

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start at', with: start_at
        fill_in 'End at', with: end_at
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("End at can't be earlier then start at")
      end
    end
  end

  context 'when guest user clicks on "create event" button on home page' do
    it 'redirects to login page' do
      visit root_path
      click_link 'Create event'

      expect(page).to have_current_path(login_path)
    end
  end

  context 'when guest visit new_event_path' do
    it 'redirects to login page' do
      visit '/events/new'

      expect(page).to have_current_path(login_path)
    end
  end
end
