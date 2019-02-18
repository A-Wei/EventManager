require 'rails_helper'

RSpec.describe Token do
  describe '#generate' do
    it 'generates secure a token' do
      token = Token.generate

      expect(token.class).to be(String)
      expect(token.length).to eq(22)
    end
  end
end
