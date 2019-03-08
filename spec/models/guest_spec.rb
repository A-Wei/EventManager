require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#logged_in?' do
    it 'returns false' do
      expect(Guest.new.logged_in?).to eq(false)
    end
  end

  describe '#checked_in?' do
    it 'returns false' do
      expect(Guest.new.checked_in?).to eq(false)
    end
  end

  describe '#checked_out?' do
    it 'returns false' do
      expect(Guest.new.checked_out?).to eq(false)
    end
  end
end
