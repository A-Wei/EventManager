class CheckInController < ApplicationController
  before_action :logged_in_user
  before_action :reset_check_in, only: [:create]

  def create
    event = Event.find(params[:id])
    CheckedInUser.create(event: event, user: current_user, checked_in_at: Time.zone.now)
    redirect_to events_path
  end

  def destroy
    checked_in_user = find_checked_in_user
    checked_in_user.checked_out_at = Time.zone.now
    checked_in_user.save
    redirect_to events_path
  end

  private

  def find_checked_in_user
    CheckedInUser.find_by(user_id: current_user.id, event_id: params[:id])
  end

  def reset_check_in
    event = Event.find(params[:id])

    if event.participants.include?(current_user)
      find_checked_in_user.checked_in_at = Time.zone.now
      find_checked_in_user.checked_out_at = nil
    end
  end
end
