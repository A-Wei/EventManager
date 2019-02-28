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
      user = create(:user, email: 'TeSt@Example.cOm')

      expect(user.email).to eq('test@example.com')
    end
  end

  describe '.search' do
    context 'when case-insensitive search only 1 term' do
      it 'returns the events that contains the given term in either name or email' do
        user1 = create(:user, name: 'calvin')
        user2 = create(:user, email: 'calvin@example.com')
        create(:user)

        result = User.search('Calvin')

        expect(result).to match_array([user1, user2])
      end
    end

    context 'when case-insensitive search multiple terms' do
      it 'returns the users that contains any given term in either name or email' do
        user1 = create(:user, name: 'calvin')
        user2 = create(:user, email: 'calvin@example.com')
        user3 = create(:user, name: 'david')
        user4 = create(:user, email: 'david@example.com')
        create(:user)

        result = User.search('Calvin David')

        expect(result).to match_array([user1, user2, user3, user4])
      end
    end
  end

  describe '#logged_in?' do
    it 'returns true' do
      expect(User.new.logged_in?).to eq(true)
    end
  end

  describe '#create_reset_password_digest' do
    it 'calls Token.generate' do
      user = create(:user)
      allow(Token).to receive(:generate)

      user.create_reset_password_digest

      expect(Token).to have_received(:generate)
    end

    it 'updates `:reset_password_digest` and `:reset_password_sent_at` columns' do
      user = create(:user)

      user.create_reset_password_digest

      expect(user.reset_password_digest).not_to eq(nil)
      expect(user.reset_password_sent_at).not_to eq(nil)
    end
  end

  describe '#authenticated?' do
    it 'returns true if give token is the password of the digest' do
      token = 'test_token'
      allow(Token).to receive(:generate).and_return(token)
      user = create(:user)

      user.create_reset_password_digest
      result = user.authenticated?(user.reset_password_digest, token)

      expect(result).to eq(true)
    end

    it 'returns false if give token is not the password of the digest' do
      token = 'test_token'
      wrong_token = 'wrong_token'
      allow(Token).to receive(:generate).and_return(token)
      user = create(:user)

      user.create_reset_password_digest
      result = user.authenticated?(user.reset_password_digest, wrong_token)

      expect(result).to eq(false)
    end
  end

  describe '#reset_password_expired?' do
    it 'returns false is user.reset_password_sent_at is within 30 minutes' do
      sent_at = 15.minutes.ago
      user = create(:user, reset_password_sent_at: sent_at)

      result = user.reset_password_expired?

      expect(result).to eq(false)
    end

    it 'returns false is user.reset_password_sent_at is more than 30 minutes' do
      sent_at = 1.hour.ago
      user = create(:user, reset_password_sent_at: sent_at)

      result = user.reset_password_expired?

      expect(result).to eq(true)
    end
  end
end
