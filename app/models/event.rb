class Event < ApplicationRecord
  validates :end_time, presence: true, in_future: true
  validates :start_time, presence: true, in_future: true
  validates :title, :location, :description, presence: true

  validates_with EndTimeLaterThanStartTime
end
