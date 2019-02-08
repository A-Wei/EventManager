FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }

  factory :user do
    name { 'Alice' }
    email
    password { 'password' }
  end
end
