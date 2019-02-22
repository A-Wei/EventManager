FactoryBot.define do
  factory :event do
    title { 'Test Event' }
    start_at { 1.hour.from_now }
    end_at { 2.hours.from_now }
    location { 'Test Location' }
    description { 'Test Description' }
  end
end
