require 'rails_helper'

RSpec.describe Token do
  describe '#generate' do
    it 'generates secure a token' do
      token = Token.generate

      expect(token.class).to be(String)
      expect(token.length).to eq(22)
    end
  end

  describe '#token_valids_for_in_words' do
    it 'returns "30 minutes"' do
      result = Token.new.token_valids_for_in_words

      expect(result).to eq('30 minutes')
    end
  end

  describe '#valid_time' do
    it 'returns 30' do
      result = Token.new.valid_time

      expect(result).to eq(30)
    end
  end
end
