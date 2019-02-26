require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    describe '#title' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:title) }
    end

    describe '#start_at' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:start_at) }
      it { is_expected.to allow_value(10.minutes.from_now).for(:start_at) }
      it { is_expected.not_to allow_value(10.minutes.ago).for(:start_at) }
      it { is_expected.not_to allow_value('some_date').for(:start_at) }

      it 'allows the `start_at` to be less than the `end_at`' do
        event = build(:event, start_at: 1.hour.from_now, end_at: 2.hours.from_now)

        expect(event).to be_valid
      end

      it 'disallows the `start_at` to be ahead of the `end_at`' do
        event = build(:event, start_at: 2.hours.from_now, end_at: 1.hour.from_now)

        expect(event).not_to be_valid
      end
    end

    describe '#end_at' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:end_at) }
      it { is_expected.to allow_value(2.hours.from_now).for(:end_at) }
      it { is_expected.not_to allow_value(2.hours.ago).for(:end_at) }
      it { is_expected.not_to allow_value('some_date').for(:end_at) }
    end

    describe '#location' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:location) }
    end

    describe '#description' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:description) }
    end
  end

  describe 'scope' do
    describe '#by_start_at' do
      it 'returns events ordered by start_at ascending order' do
        travel_to Time.new(2019,02,01,07) do
          apr_event = create(:event, start_at: '2019-04-01, 10:00', end_at: '2019-04-01, 11:00')
          mar_event = create(:event, start_at: '2019-03-01, 10:00', end_at: '2019-03-01, 11:00')
          feb_event = create(:event, start_at: '2019-02-01, 10:00', end_at: '2019-02-01, 11:00')

          events = Event.all.by_start_at_asc

          expect(events).to eq([feb_event, mar_event, apr_event])
        end
      end
    end
  end

  describe '#creator?' do
    it 'returns true when the given user is the event creator' do
      user = build(:user)
      event = build(:event, user: user)

      result = event.creator?(user)

      expect(result).to eq(true)
    end

    it 'returns false when the given_user is not the event creator' do
      user = build(:user)
      event = build(:event)

      result = event.creator?(user)

      expect(result).to eq(false)
    end
  end
end
