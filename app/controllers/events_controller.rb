class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)

    if event.save
      redirect_to event
    else
      flash[:error] = event.errors.full_messages.to_sentence
      redirect_to new_event_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    event.update_attributes(event_params)

    redirect_to event
  end

  private

  attr_reader :event

  def event_params
    params.require(:event).permit(:title, :start_at, :end_at, :location, :description)
  end
end
