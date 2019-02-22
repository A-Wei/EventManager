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
      it { is_expected.to allow_value(Time.zone.now + 10.minutes).for(:start_at) }
      it { is_expected.not_to allow_value(Time.zone.now - 10.minutes).for(:start_at) }
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
      it { is_expected.to allow_value(Time.zone.now + 3.hours).for(:end_at) }
      it { is_expected.not_to allow_value(Time.zone.now - 10.minutes).for(:end_at) }
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
end
