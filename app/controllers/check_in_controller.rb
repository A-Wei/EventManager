class CheckInController < ApplicationController
  def create
    event = Event.find(params[:id])
    CheckedInUser.create(event: event, user: current_user)
    redirect_to events_path
  end
end
