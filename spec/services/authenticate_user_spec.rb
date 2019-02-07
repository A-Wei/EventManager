require 'rails_helper'

RSpec.describe AuthenticateUser do
  describe '.call' do
    context 'when user already signed up' do
      it 'returns the user object if password is correct' do
        password = 'foobar'
        user = create(
          :user,
          name: 'Bob',
          email: 'bob@example.com',
          password: password,
          password_confirmation: password,
        )

        result = AuthenticateUser.call(user: user, password: password)

        expect(result).to eq(user)
      end

      it "returns 'false' if password is incorrect" do
        password = 'foobar'
        incorrect_password = 'incorrect_password'
        user = create(
          :user,
          name: 'Bob',
          email: 'bob@example.com',
          password: password,
          password_confirmation: password,
        )

        result = AuthenticateUser.call(user: user, password: incorrect_password)

        expect(result).to eq(false)
      end
    end

    context 'when user not signed up' do
      it "returns nil" do
        password = 'foobar'
        user = nil

        result = AuthenticateUser.call(user: user, password: password)

        expect(result).to eq(nil)
      end
    end
  end
end
