class CheckInController < ApplicationController
  before_action :logged_in_user

  def create
    find_event
    create_event_attendant
    redirect_to events_path
  end

  def destroy
    find_event_attendant
    event_attendant.check_out
    redirect_to events_path
  end

  private

  attr_reader :event, :event_attendant

  def find_event_attendant
    @event_attendant = EventAttendant.find_by(event_id: params[:id], user_id: current_user.id)
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def create_event_attendant
    EventAttendant.create(event: event, user: current_user, checked_in_at: Time.zone.now)
  end
end
