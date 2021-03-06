require 'rails_helper'

RSpec.describe EventAttendant, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event) }
  end

  describe 'validations' do
    subject { build(:event_attendant) }

    it { is_expected.to validate_presence_of(:event_id) }
    it { is_expected.to validate_presence_of(:user_id) }
    it do
      is_expected.to validate_uniqueness_of(:user)
        .scoped_to(:event_id)
        .with_message('already checked in')
    end
  end

  describe '.checked_in?' do
    context 'when event attendant is present' do
      it 'returns true when checked_in_at is present and checked_out_at is nil' do
        user = create(:user)
        event = create(:event)
        create(
          :event_attendant,
          user: user,
          event: event,
          checked_in_at: 1.hour.ago,
          checked_out_at: nil,
        )

        result = EventAttendant.checked_in?(event, user)

        expect(result).to eq(true)
      end

      it 'returns false when both checked_in_at and checked_out_at are present' do
        user = create(:user)
        event = create(:event)
        create(
          :event_attendant,
          user: user,
          event: event,
          checked_in_at: 2.hour.ago,
          checked_out_at: 1.hour.ago,
        )

        result = EventAttendant.checked_in?(event, user)

        expect(result).to eq(false)
      end

      it 'returns false when checked_in_at is nil' do
        user = create(:user)
        event = create(:event)
        create(
          :event_attendant,
          user: user,
          event: event,
          checked_in_at: nil,
        )

        result = EventAttendant.checked_in?(event, user)

        expect(result).to eq(false)
      end
    end

    context 'when event attendant is not present' do
      it 'returns false' do
        user = build(:user)
        event = build(:event)

        result = EventAttendant.checked_in?(event, user)

        expect(result).to eq(false)
      end
    end
  end

  describe '.checked_out?' do
    context 'when event attendant is present' do
      it 'returns true when checked_out_at is present' do
        user = create(:user)
        event = create(:event)
        create(
          :event_attendant,
          user: user,
          event: event,
          checked_in_at: 2.hour.ago,
          checked_out_at: 1.hour.ago,
        )

        result = EventAttendant.checked_out?(event, user)

        expect(result).to eq(true)
      end

      it 'returns false when checked_out_at is nil' do
        user = create(:user)
        event = create(:event)
        create(
          :event_attendant,
          user: user,
          event: event,
          checked_in_at: 1.hour.ago,
          checked_out_at: nil,
        )

        result = EventAttendant.checked_out?(event, user)

        expect(result).to eq(false)
      end
    end

    context 'when event attendant is not present' do
      it 'returns false' do
        user = build(:user)
        event = build(:event)

        result = EventAttendant.checked_out?(event, user)

        expect(result).to eq(false)
      end
    end
  end

  describe '#check_out' do
    it 'updates the checked_out_at to the current time' do
      travel_to Time.new(2019, 1, 1, 10) do
        event_attendant = create(:event_attendant)

        event_attendant.check_out

        expect(event_attendant.checked_out_at).to eq(Time.zone.now)
      end
    end
  end
end
