require 'rails_helper'

RSpec.describe SessionsHelper do
  describe '#current_user' do
    context 'when a user logs in' do
      it 'sets the current_user to logged in user' do
        user = create(:user)
        session[:user_id] = user.id

        current_user

        expect(current_user).to eq(user)
      end
    end

    context 'when user is not logged in' do
      it 'sets the current_user to nil' do
        current_user

        expect(current_user).to eq(nil)
      end
    end
  end
end