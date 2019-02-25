require 'rails_helper'

RSpec.describe EventPolicy do
  describe '.edit?' do
    it 'returns true if user is the event creator' do
      user = create(:user)
      event = create(:event, user: user)

      result = EventPolicy.new(user, event)

      expect(result.edit?).to eq(true)
    end

    it 'returns false if user is not the event creator' do
      user = create(:user)
      event = create(:event)

      result = EventPolicy.new(user, event)

      expect(result.edit?).to eq(false)
    end
  end
end
