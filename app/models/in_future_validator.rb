class InFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    if value < Time.zone.now
      record.errors.add(attribute, "#{attribute} cannot be in the past")
    end
  end
end
