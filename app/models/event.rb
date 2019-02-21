class Event < ApplicationRecord
  validates :title, :location, :description, :start_time, :end_time, presence: true
end
