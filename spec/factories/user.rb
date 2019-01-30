FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }

  factory :user do
    name 'example user'
    email
    password_digest '$2a$10$LUCYkir.TbTbseZLHECeROfnWiqn.sWxjGBpgV6f5wqNgbxfli6Ee'
  end
end