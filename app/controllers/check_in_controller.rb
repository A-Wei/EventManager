class CheckInController < ApplicationController
  def create
    event = Event.find(params[:id])
    CheckedInUser.create(event: event, user: current_user)
    redirect_to events_path
  end

  def destroy
    checked_in_user = find_checked_in_user
    checked_in_user.destroy
    redirect_to events_path
  end

  private

  def find_checked_in_user
    CheckedInUser.find_by(user_id: current_user.id, event_id: params[:id])
  end
end
