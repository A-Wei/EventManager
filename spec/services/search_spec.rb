require 'rails_helper'

RSpec.describe Search do
  describe '.for' do
    context 'when searching only for events' do
      it 'returns the matching events' do
        event1 = create(:event, title: 'Unique title')
        event2 = create(:event, location: 'Unique location')
        event3 = create(:event, description: 'Unique description')
        create(:event)

        result = Search.for('unique')

        expect(result).to eq([event1, event2, event3])
      end
    end

    context 'when searching only for users' do
      it 'returns the matching users' do
        user1 = create(:user, name: 'calvin')
        user2 = create(:user, email: 'calvin@example.com')
        create(:user)

        result = Search.for('calvin')

        expect(result).to eq([user1, user2])
      end
    end

    context 'when searching for both events and users' do
      it 'returns the matching objects' do
        user = create(:user, name: 'bob')
        event = create(:event, title: "Bob's birthday")
        create(:user)
        create(:event)

        result = Search.for('bob')

        expect(result).to match_array([event, user])
      end
    end
  end
end
