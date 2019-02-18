require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#password_reset' do
    it 'sends the password_reset mailer to the submitted email' do
      user = create(:user)
      user.password_reset_token = 'test_token'

      mail = UserMailer.password_reset(user).deliver_now

      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match(user.password_reset_token)
    end
  end
end
