require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#logged_in?' do
    it 'returns false' do
      expect(Guest.new.logged_in?).to eq(false)
    end
  end
end