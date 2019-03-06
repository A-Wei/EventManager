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
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:event_id) }
  end
end
