require 'rails_helper'

RSpec.describe ValidateUser do
  describe '.call' do
    it 'returns a ValidateUser::Result object' do
      id = 'id'
      user = create(:user)

      validated_user = ValidateUser.call(user: user, id: id)

      expect(validated_user.class).to eq(ValidateUser::Result)
    end
  end

  describe '#expired?' do
    it 'returns false if user.reset_password_token was generated within 30 minutes' do
      user = create(
        :user,
        reset_password_sent_at: 10.minutes.ago,
      )

      validated_user = ValidateUser.call(user: user, id: nil)

      expect(validated_user.expired?).to eq(false)
    end

    it 'returns true if user.reset_password_token was generated more than 30 minutes' do
      user = create(
        :user,
        reset_password_sent_at: 40.minutes.ago,
      )

      validated_user = ValidateUser.call(user: user, id: nil)

      expect(validated_user.expired?).to eq(true)
    end
  end

  describe '#not_authenticated?' do
    it 'returns true if id(or token) is not the key for user.reset_password_digest' do
      user = create(:user)
      token = 'some_token_id'
      allow(Token).to receive(:generate).and_return(token)

      user.create_reset_password_digest
      validated_user = ValidateUser.call(user: user, id: 'wrong_token')

      expect(validated_user.not_authenticated?).to eq(true)
    end

    it 'returns false if id(or token) is the key for user.reset_password_digest' do
      user = create(:user)
      token = 'some_token_id'
      allow(Token).to receive(:generate).and_return(token)

      user.create_reset_password_digest
      validated_user = ValidateUser.call(user: user, id: token)

      expect(validated_user.not_authenticated?).to eq(false)
    end
  end
end
