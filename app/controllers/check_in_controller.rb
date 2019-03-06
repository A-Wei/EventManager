class CheckInController < ApplicationController
  before_action :logged_in_user

  def create
    event = Event.find(params[:id])
    EventAttendant.create(event: event, user: current_user, checked_in_at: Time.zone.now)
    redirect_to events_path
  end

  def destroy
    event_attendent = find_attendant
    event_attendent.checked_out_at = Time.zone.now
    event_attendent.save
    redirect_to events_path
  end

  private

  def find_attendant
    EventAttendant.find_by(event_id: params[:id], user_id: current_user.id)
  end
end
