require 'rails_helper'

RSpec.describe EventDecorator do
  describe '#start_and_end_at' do
    context 'When start_at and end_at have the same date' do
      it 'returns the formate "%Y-%m-%d,%H:%M" to "%H:%M"' do
        start_at = 1.day.from_now.beginning_of_day
        end_at = 1.day.from_now
        event = build(:event, start_at: start_at, end_at: end_at)
        decorated = event.decorate

        result = decorated.start_and_end_at

        string = "#{start_at.strftime('%Y-%m-%d,%H:%M')} to #{end_at.strftime('%H:%M')}"
        expect(result).to eq(string)
      end

      it 'returns the formate "%Y-%m-%d,%H:%M" to "%Y-%m-%d,%H:%M"' do
        start_at = 1.day.from_now
        end_at = 2.days.from_now
        event = build(:event, start_at: start_at, end_at: end_at)
        decorated = event.decorate

        result = decorated.start_and_end_at

        string = "#{start_at.strftime('%Y-%m-%d,%H:%M')} to #{end_at.strftime('%Y-%m-%d,%H:%M')}"
        expect(result).to eq(string)
      end
    end
  end
end
