FactoryGirl.define do
  factory :license do
    association :product
    expire_on { 7.weeks.from_now }
  end
end
