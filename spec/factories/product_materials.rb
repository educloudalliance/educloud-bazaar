FactoryGirl.define do
  factory :product_meterial do
    association :product
    association :material
  end
end
