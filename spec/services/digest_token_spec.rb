require 'rails_helper'

RSpec.describe DigestToken do
  describe '#generate' do
    it 'converts a token into digest' do
      token = 'a_test_token'

      digest = DigestToken.generate(string: token).to_s

      expect(digest).not_to eq(token)
    end
  end
end
