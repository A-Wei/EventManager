FactoryBot.define do
  factory :event_attendant do
    event
    user
    checked_in_at  { 2.hours.ago }
    checked_out_at { 1.hour.ago }
  end
end
