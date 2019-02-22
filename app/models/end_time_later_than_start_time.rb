class EndTimeLaterThanStartTime < ActiveModel::Validator
  def validate(record)
    if record.end_time.nil? || record.start_time.nil?
    elsif record.start_time > record.end_time
      record.errors.add(:end_time, "can't be earlier then start time")
    end
  end
end
