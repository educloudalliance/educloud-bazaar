FactoryGirl.define do
  factory :materials_metadata, class: 'MaterialsMetadata' do
    association :material
    association :metadata
  end
end
