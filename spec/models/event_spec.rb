require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    describe '#title' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:title) }
    end

    describe '#start_time' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:start_time) }
      it { is_expected.to allow_value(Time.zone.now + 10.minutes).for(:start_time) }
      it { is_expected.not_to allow_value(Time.zone.now - 10.minutes).for(:start_time) }
      it { is_expected.not_to allow_value('some_date').for(:start_time) }
    end

    describe '#end_time' do
      subject { build(:event) }

      it { is_expected.to validate_presence_of(:end_time) }
      it { is_expected.to allow_value(Time.zone.now + 3.hours).for(:end_time) }
      it { is_expected.not_to allow_value(Time.zone.now - 10.minutes).for(:end_time) }
      it { is_expected.not_to allow_value('some_date').for(:end_time) }
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
