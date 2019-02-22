FactoryBot.define do
  factory :event do
    title { 'Test Event' }
    start_at { Time.zone.now + 1.hour }
    end_at { Time.zone.now + 2.hours }
    location { 'Test Location' }
    description { 'Test Descriptio' }
  end
end
