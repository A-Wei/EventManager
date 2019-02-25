require 'rails_helper'

RSpec.describe EventDecorator do
  describe '#date_range' do
    context 'when start_at and end_at have the same date' do
      it 'returns the formate "%Y-%m-%d,%H:%M" to "%H:%M"' do
        travel_to Time.new(2019, 1, 1, 7) do
          start_at = '2019-01-01, 10:00'
          end_at = '2019-01-01, 11:00'
          event = build(:event, start_at: start_at, end_at: end_at)
          decorated = event.decorate

          result = decorated.date_range

          string = '2019-01-01,10:00 to 11:00'
          expect(result).to eq(string)
        end
      end

      it 'returns the formate "%Y-%m-%d,%H:%M" to "%Y-%m-%d,%H:%M"' do
        travel_to Time.new(2019, 1, 1, 7) do
          start_at = '2019-01-01, 10:00'
          end_at = '2019-01-02, 10:00'
          event = build(:event, start_at: start_at, end_at: end_at)
          decorated = event.decorate

          result = decorated.date_range

          string = '2019-01-01,10:00 to 2019-01-02,10:00'
          expect(result).to eq(string)
        end
      end
    end
  end
end
