FactoryGirl.define do
  factory :material_tag do
    association :material
    association :tag
  end
end
