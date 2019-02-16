require 'rails_helper'

RSpec.describe 'User forgets their password', type: :system do
  context 'when user clicks on "forget password"' do
    context 'when the submitted email exist' do
      it 'sends an email to user email and notifies user' do
        user = create(:user)

        forget_password(user.email)

        expect(page).to have_text('Check your email')
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end

    context 'when the email does not exist' do
      it "shows a 'user doesn't exist' error" do
        forget_password('incorrect@example.com')

        expect(page).to have_text('Check your email')
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end
end
