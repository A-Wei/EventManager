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
    TIME_REGEX = /
      [0-9]{4}
      -
      (0[1-9]|1[0-2])
      -
      ([0-2][0-9]|3[0-1])
      ,?
      \s?
      (2[0-3]|[01][0-9])
      :
      [0-5][0-9]
      (.{9})?
    /x.freeze

    def initialize(params)
      @params = params
      @event_start_time = params[:start_time]
      @event_end_time = params[:end_time]
    end

    def invalid_start_time?
      Time.zone.now > event_start_time
    end

    def invalid_end_time?
      event_end_time < event_start_time
    end

    def invalid_time_format?
      TIME_REGEX !~ event_start_time || TIME_REGEX !~ event_end_time
    end

    private

    attr_reader :event_start_time, :event_end_time
  end
end
