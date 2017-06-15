FactoryGirl.define do
  factory :product do
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.phrase }
  end
end
