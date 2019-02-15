require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#password_reset' do
    context 'when user submits an email' do
      it 'sends the password_reset mailer to the submitted email' do
        user = create(:user)
        user.password_reset_token = User.new_token

        mail = user.send_password_reset_email

        expect(mail.to).to eq([user.email])
        expect(mail.body.encoded).to match(user.password_reset_token)
      end
    end
  end
end
