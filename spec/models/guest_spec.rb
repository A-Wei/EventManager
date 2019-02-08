require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#signed_in?' do
    it 'returns false' do
      expect(Guest.new.signed_in?).to be false
    end
  end
end
