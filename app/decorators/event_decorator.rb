class EventDecorator < ApplicationDecorator
  delegate_all

  def date_range
    if one_day_event?
      "#{start_at.strftime('%Y-%m-%d,%H:%M')} to #{end_at.strftime('%H:%M')}"
    else
      "#{start_at.strftime('%Y-%m-%d,%H:%M')} to #{end_at.strftime('%Y-%m-%d,%H:%M')}"
    end
  end

  private

  def one_day_event?
    start_at.to_date == end_at.to_date
  end
end
