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
end
