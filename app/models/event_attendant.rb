class EventAttendant < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :event_id }
  validates :event_id, presence: true
end
