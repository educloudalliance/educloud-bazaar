FactoryGirl.define do
  factory :material do
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.phrase }
    language { FFaker::Locale.code }
    publisher_resource_id { Time.current.to_i }
  end
end
