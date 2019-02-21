require 'rails_helper'

RSpec.describe 'User creates event', type: :system do
  context 'when logged in user clicks "create event" button on home page' do
    context 'when event data is correct' do
      it 'creates an event and redirect to event home page' do
        user = create(:user)
        start_time = Time.now + 1.hour
        end_time = Time.now + 2.hours

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
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
        start_time = Time.now + 1.hour
        end_time = Time.now + 2.hours

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Title can't be blank")
      end

      it "shows 'Location can't be blank' error and rerender the page" do
        user = create(:user)
        start_time = Time.now + 1.hour
        end_time = Time.now + 2.hours

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Location can't be blank")
      end

      it "shows 'Description can't be blank' error and rerender the page" do
        user = create(:user)
        start_time = Time.now + 1.hour
        end_time = Time.now + 2.hours

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
        fill_in 'Location', with: 'Online'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text("Description can't be blank")
      end

      it "shows 'Start time invalid' error if start time earlier than current time" do
        user = create(:user)
        start_time = Time.now - 2.hours
        end_time = Time.now - 1.hour

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text('Start time invalid')
      end

      it "shows 'End time is earlier than start time' error" do
        user = create(:user)
        start_time = Time.now + 2.hours
        end_time = Time.now + 1.hour

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text('End time is earlier than start time')
      end

      it 'shows "start time or end time formate is incorrect, please try again"' do
        user = create(:user)
        start_time = '03/31/2019 06:30'
        end_time = '03/31/2019 07:30'

        login(user)
        visit root_path
        click_link 'Create event'
        fill_in 'Title', with: 'Test event'
        fill_in 'Start time', with: start_time
        fill_in 'End time', with: end_time
        fill_in 'Location', with: 'Online'
        fill_in 'Description', with: 'Some description'
        click_button 'Create'

        expect(page).to have_current_path(new_event_path)
        expect(page).to have_text('formate is incorrect')
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
