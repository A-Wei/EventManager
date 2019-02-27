require 'rails_helper'

RSpec.describe Search do
  describe '.for' do
    context 'when searching only for events' do
      it 'returns the matching events' do
        event = create(:event, title: 'Test event')
        create(:event, title: 'Some event')

        result = Search.for('test')

        expect(result).to eq([event])
      end
    end

    context 'when searching only for users' do
      it 'returns the matching users' do
        alice = create(:user, email: 'alice@example.com')
        create(:user, email: 'bob@example.com')

        result = Search.for('alice')

        expect(result).to eq([alice])
      end
    end

    context 'when searching for both events and users' do
      it 'returns the matching objects' do
        alice = create(:user, email: 'alice@example.com')
        create(:user, email: 'bob@example.com')
        event = create(:event, title: "Alice's birthday")
        create(:event, title: "Bob's birthday")

        result = Search.for('alice')

        expect(result).to match_array([event, alice])
      end
    end
  end
end
