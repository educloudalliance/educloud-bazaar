FactoryGirl.define do
  factory :material do
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.phrase }
    language { FFaker::Locale.code }
    sequence(:publisher_resource_id) { |n| n + rand(1_000_000) }
    image { File.open(Rails.root.join('spec', 'fixtures', 'ruby.png')) }
    after(:build) do |material|
      material.tag_list = FFaker::Lorem.words
      material.metadata << FactoryGirl.create(:metadata)
    end
  end
end
