class Event < ApplicationRecord
  validates :end_time, presence: true, in_future: true
  validates :start_time, presence: true, in_future: true
  validates :title, :location, :description, presence: true

  validate :end_time_ahead_of_start_time

  private

  def end_time_ahead_of_start_time
    return if start_time.nil? || end_time.nil?

    if start_time > end_time
      errors.add(:end_time, message: "End time can't be earlier then start time")
    end
  end
end
