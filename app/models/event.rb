class Event < ApplicationRecord
  validates :title, :location, :description, :start_time, :end_time, presence: true
  validates_with StartTimeInFuture
  validates_with EndTimeLaterThanStartTime
end
