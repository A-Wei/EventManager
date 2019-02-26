class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def index
    @events = Event.all.in_future.decorate
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.user = current_user

    if event.save
      redirect_to event
    else
      flash[:error] = event.errors.full_messages.to_sentence
      redirect_to new_event_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    event = Event.find(params[:id])

    if event.update_attributes(event_params)
      redirect_to events_path
    else
      flash[:error] = event.errors.full_messages.to_sentence
      redirect_to edit_event_path
    end
  end

  def destroy
    event = Event.find(params[:id])

    if event.destroy
      flash[:success] = "#{event.title} has been deleted"
      redirect_to events_path
    else
      flash[:error] = event.errors.full_messages.to_sentence
      redirect_to edit_event_path
    end
  end

  private

  attr_reader :event

  def event_params
    params.require(:event).permit(:title, :start_at, :end_at, :location, :description)
  end
end
