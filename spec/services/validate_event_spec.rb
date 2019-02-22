require 'rails_helper'

RSpec.describe ValidateEvent do
  describe '.call' do
    it 'returns a "TimeValidator" object' do
      params = ActionController::Parameters.new

      object = ValidateEvent.call(params)

      expect(object.class).to eq(ValidateEvent::TimeValidator)
    end
  end

  describe '#invalid_time_format?' do
    it 'returns false if start_time and end_time format are both correct' do
      start_time = '2019-02-02 13:30'
      end_time = '2019-02-02 14:30'
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_time_format?).to eq(false)
    end

    it 'returns true if start_time or end_time format is not correct' do
      start_time = '2019/02/02 13:30'
      end_time = '2019-02-02 14:30'
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_time_format?).to eq(true)
    end

    it 'returns true if start_time and end_time format are both not correct' do
      start_time = '2019/02/02 13:30'
      end_time = '2019/02/02 14:30'
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_time_format?).to eq(true)
    end
  end
end
