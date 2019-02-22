class StartTimeInFuture < ActiveModel::Validator
  def validate(record)
    if record.start_time.nil?
    elsif Time.zone.now > record.start_time
      record.errors.add(:start_time, "can't be in the past")
    end
  end
end
