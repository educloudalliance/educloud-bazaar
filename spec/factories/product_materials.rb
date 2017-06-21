FactoryGirl.define do
  factory :product_material do
    association :product
    association :material
  end
end
