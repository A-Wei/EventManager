require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { should_not allow_value('test@testcom').for(:email) }
    it 'validates uniquess of email' do
      create(:user, password: 'foobar', password_confirmation: 'foobar')
      should validate_uniqueness_of(:email).case_insensitive
    end
  end

  describe '.new' do
    it 'creates a valid user when email is valid' do
      user = create(
        :user,
        name: 'test',
        email: 'test@test.com',
        password: 'foobar',
        password_confirmation: 'foobar',
      )

      expect(user).to be_valid
    end
  end

  describe '#downcase' do
    it 'saves the emails as lower-case' do
      user = create(
        :user,
        name: 'test',
        email: 'TeSt@tEsT.cOm',
        password: 'foobar',
        password_confirmation: 'foobar',
      )

      expect(user.email).to eq('test@test.com')
    end
  end
end
