require 'rails_helper'

RSpec.describe EventHelper do
  describe '#check_in_button' do
    it "returns 'Check in' link when have't check in" do
      user = create(:user)
      event = create(:event)
      create(
        :event_attendant,
        user: user,
        event: event,
        checked_in_at: nil,
        checked_out_at: nil,
      )

      button = check_in_button(event, user)

      expect(button).to include('Check In')
    end

    it "returns 'Check out' link when user have checked in" do
      user = create(:user)
      event = create(:event)
      create(
        :event_attendant,
        user: user,
        event: event,
        checked_in_at: 1.hour.ago,
        checked_out_at: nil,
      )

      button = check_in_button(event, user)

      expect(button).to include('Check Out')
    end

    it "returns 'Participated' link when user have checked out" do
      user = create(:user)
      event = create(:event)
      create(
        :event_attendant,
        user: user,
        event: event,
        checked_in_at: 2.hour.ago,
        checked_out_at: 1.hour.ago,
      )

      button = check_in_button(event, user)

      expect(button).to include('Participated')
    end
  end
end
