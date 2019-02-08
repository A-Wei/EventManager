require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#email' do
      subject { build(:user) }

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.to allow_value('test@example.com').for(:email) }
      it { is_expected.not_to allow_value('test@examplecom').for(:email) }
    end

    describe '#password' do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end
  end

  describe 'before_create' do
    it 'saves the emails as lowercase' do
      user = create(:user, email: 'TeSt@tEsT.cOm')

      expect(user.email).to eq('test@test.com')
    end
  end

  describe '#signed_in?' do
    it 'returns true' do
      expect(User.new.signed_in?).to be true
    end
  end
end
