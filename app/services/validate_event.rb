class ValidateEvent
  def self.call(*args)
    new(*args).call
  end

  def initialize(params)
    @params = params
  end

  def call
    TimeValidator.new(params)
  end

  private

  attr_reader :params

  class TimeValidator
    def initialize(params)
      @params = params
      @event_start_time = params[:start_time]
      @event_end_time = params[:end_time]
    end

    def valid_start_time?
      event_start_time < Time.zone.now
    end

    def valid_end_time?
      event_end_time < event_start_time
    end

    private

    attr_reader :params, :event_start_time, :event_end_time
  end
end
