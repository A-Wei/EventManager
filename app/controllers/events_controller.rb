class EventsController < ApplicationController
  before_action :validate_start_and_end_time, only: [:create]
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
      flash[:error] = event.errors.full_messages
      redirect_to new_event_path
    end
  end

  private

  attr_reader :validated_event

  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :location, :description)
  end

  def validate_start_and_end_time
    validated_event = ValidateEvent.call(params[:event])

    if validated_event.valid_start_time?
      flash[:error] = 'Start time invalid'
      redirect_to new_event_path
    elsif validated_event.valid_end_time?
      flash[:error] = 'End time is earlier than start time'
      redirect_to new_event_path
    end
  end
end
