require 'rails_helper'

RSpec.describe InFutureValidator do
  it 'validates if the given attribute is in the future' do
    model = Class.new do
      include ActiveModel::Model

      attr_accessor :start_at
    end
    record = model.new(start_at: 1.hour.from_now)
    validator = InFutureValidator.new(
      attributes: [:start_at],
    )

    validator.validate(record)

    expect(record.errors).to be_empty
  end

  it 'adds an error when the given attribute is in the past' do
    model = Class.new do
      include ActiveModel::Model

      attr_accessor :start_at
    end
    record = model.new(start_at: 1.hour.ago)
    validator = InFutureValidator.new(
      attributes: [:start_at],
    )

    validator.validate(record)

    expect(record.errors).not_to be_empty
    expect(record.errors[:start_at]).to eq(["can't be in the past"])
  end

  it 'handles when the value is nil' do
    model = Class.new do
      include ActiveModel::Model

      attr_accessor :start_at
    end
    record = model.new(start_at: nil)
    validator = InFutureValidator.new(
      attributes: [:start_at],
    )

    validator.validate(record)

    expect(record).to be_valid
  end
end
