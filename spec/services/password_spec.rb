require 'rails_helper'

RSpec.describe Password, type: :model do
  describe 'validations' do
    describe '#password' do
      it { is_expected.to validate_confirmation_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
      it { is_expected.to validate_presence_of(:password) }
    end

    describe '#password_confirmation' do
      it { is_expected.to validate_length_of(:password_confirmation).is_at_least(6) }
      it { is_expected.to validate_presence_of(:password_confirmation) }
    end
  end
end
