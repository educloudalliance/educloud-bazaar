FactoryGirl.define do
  factory :account do
    name { FFaker::Product.name }
    sequence(:email) { |n| "factory_user_#{n}@example.com" }
    password 'password'
  end
end
