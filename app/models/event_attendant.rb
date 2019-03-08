class EventAttendant < ApplicationRecord
  belongs_to :event
  belongs_to :user

  delegate :title, to: :event, prefix: :event

  validates_presence_of :user_id, :event_id
  validates_uniqueness_of :user, scope: :event_id, message: 'already checked in'

  def self.checked_in?(event, user)
    event_attendant = EventAttendant.find_by(event_id: event.id, user_id: user.id)

    event_attendant.present? &&
      event_attendant.checked_in_at.present? &&
      event_attendant.checked_out_at.nil?
  end

  def self.checked_out?(event, user)
    event_attendant = EventAttendant.find_by(event_id: event.id, user_id: user.id)

    event_attendant.present? && event_attendant.checked_out_at.present?
  end

  def check_out
    update_attributes(checked_out_at: Time.zone.now)
  end
end
