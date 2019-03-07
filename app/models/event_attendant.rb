class EventAttendant < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :event_id }
  validates :event_id, presence: true

  def self.checked_in?(event_id, user_id)
    event_attendant = EventAttendant.find_by(event_id: event_id, user_id: user_id)

    event_attendant.present? &&
      event_attendant.checked_in_at.present? &&
      event_attendant.checked_out_at.nil?
  end

  def self.checked_out?(event_id, user_id)
    event_attendant = EventAttendant.find_by(event_id: event_id, user_id: user_id)

    event_attendant.present? && event_attendant.checked_out_at.present?
  end
end
