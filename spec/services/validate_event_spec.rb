require 'rails_helper'

RSpec.describe ValidateEvent do
  describe '.call' do
    it 'returns a "TimeValidator" object' do
      params = ActionController::Parameters.new()

      object = ValidateEvent.call(params)

      expect(object.class).to eq(ValidateEvent::TimeValidator)
    end
  end

  describe '#invalid_start_time?' do
    it 'returns true if start_time is in the past' do
      start_time = Time.zone.now - 2.hours
      end_time = Time.zone.now - 1.hour
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_start_time?).to eq(true)
    end

    it 'returns false if start_time is in the future' do
      start_time = Time.zone.now + 1.hour
      end_time = Time.zone.now + 2.hours
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_start_time?).to eq(false)
    end
  end

  describe '#invalid_end_time?' do
    it 'returns true if end_time is earlier than start_time ' do
      start_time = Time.zone.now + 2.hours
      end_time = Time.zone.now + 1.hour
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_end_time?).to eq(true)
    end

    it 'returns false if end_time is later than start_time' do
      start_time = Time.zone.now + 1.hour
      end_time = Time.zone.now + 2.hours
      params = ActionController::Parameters.new(start_time: start_time, end_time: end_time)

      result = ValidateEvent.call(params)

      expect(result.invalid_end_time?).to eq(false)
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
