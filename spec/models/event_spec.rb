require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    describe '#title' do
      it { is_expected.to validate_presence_of(:title) }
    end

    describe '#start_time' do
      it { is_expected.to validate_presence_of(:start_time) }
      it { is_expected.to allow_value('2019-02-02 12:00:00').for(:start_time) }
      it { is_expected.not_to allow_value('some_date').for(:start_time) }
    end

    describe '#end_time' do
      it { is_expected.to validate_presence_of(:end_time) }
      it { is_expected.to allow_value('2019-02-02 12:00:00').for(:end_time) }
      it { is_expected.not_to allow_value('some_date').for(:end_time) }
    end

    describe '#location' do
      it { is_expected.to validate_presence_of(:location) }
    end

    describe '#description' do
      it { is_expected.to validate_presence_of(:description) }
    end
  end
end
