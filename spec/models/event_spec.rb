require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:checked_in_users) }
    it { is_expected.to have_many(:participants).through(:checked_in_users) }
  end

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
    describe '.in_future' do
      it 'returns future events ordered by start_at ascending order' do
        travel_to Time.new(2019, 1, 1, 7) do
          create(:event, start_at: '2019-01-01, 10:00', end_at: '2019-01-01, 11:00')
          create(:event, start_at: '2019-01-02, 10:00', end_at: '2019-01-02, 11:00')
        end

        travel_to Time.new(2019, 2, 1, 7) do
          apr_event = create(:event, start_at: '2019-04-01, 10:00', end_at: '2019-04-01, 11:00')
          mar_event = create(:event, start_at: '2019-03-01, 10:00', end_at: '2019-03-01, 11:00')
          feb_event = create(:event, start_at: '2019-02-01, 10:00', end_at: '2019-02-01, 11:00')

          events = Event.in_future

          expect(Event.all.count).to eq(5)
          expect(events).to eq([feb_event, mar_event, apr_event])
        end
      end
    end
  end

  describe '.search' do
    context 'when case-insensitive search only 1 term' do
      it 'returns the events that contains the given term in either title/location/description' do
        event1 = create(:event, title: 'Example')
        event2 = create(:event, location: 'example')
        event3 = create(:event, description: 'example')
        create(:event)

        result = Event.search('example')

        expect(result).to eq([event1, event2, event3])
      end
    end

    context 'when case-insensitive search multiple terms' do
      it 'returns the events that contains any given term in either title/location/description' do
        event1 = create(:event, title: 'amazing')
        event2 = create(:event, location: 'new')
        event3 = create(:event, description: 'example')
        create(:event)

        result = Event.search('Amazing New Example')

        expect(result).to eq([event1, event2, event3])
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

  describe '#checked_in?' do
    it 'returns true if user have checked in' do
      user = build(:user)
      event = build(:event)
      create(:checked_in_user, event: event, user: user)

      result = event.checked_in?(user)

      expect(result).to eq(true)
    end

    it 'returns false if user have not checked in' do
      user = build(:user)
      event = build(:event)
      create(:checked_in_user, event: event)

      result = event.checked_in?(user)

      expect(result).to eq(false)
    end
  end

  describe '#checked_out?' do
    it 'returns true if user have checked out' do
      user = build(:user)
      event = build(:event)
      create(
        :checked_in_user,
        event: event,
        user: user,
        checked_in_at: 1.hour.ago,
        checked_out_at: Time.zone.now
      )

      result = event.checked_out?(user)

      expect(result).to eq(true)
    end

    it 'returns false if user have not checked out' do
      user = build(:user)
      event = build(:event)
      create(:checked_in_user, event: event, user: user, checked_in_at: 1.hour.ago)

      result = event.checked_out?(user)

      expect(result).to eq(false)
    end
  end
end
