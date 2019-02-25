require 'rails_helper'

RSpec.describe EventsHelper do
  describe '#creator?' do
    it 'returns true if the current_user is the event creator' do
      user = build(:user)
      event = build(:event, user: user)

      result = creator?(user, event)

      expect(result).to eq(true)
    end

    it 'returns false if the current_user is not the event creator' do
      user = build(:user)
      event = build(:event)

      result = creator?(user, event)

      expect(result).to eq(false)
    end
  end

  describe '#pretty_title?' do
    it 'returns titlelized event title' do
      event = build(:event, title: 'new event')

      title = pretty_title(event)

      expect(title).to eq('New Event')
    end
  end
end
