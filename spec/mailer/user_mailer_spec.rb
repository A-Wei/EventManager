require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#reset_password' do
    it 'sends the reset_password mailer to the submitted email' do
      user = create(:user)
      user.reset_password_token = 'test_token'

      mail = UserMailer.reset_password(user).deliver_now

      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match(user.reset_password_token)
    end
  end
end
