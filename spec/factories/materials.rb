FactoryGirl.define do
  factory :material do
    association :account
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.phrase }
    language { FFaker::Locale.code }
    publisher_resource_id { SecureRandom.uuid }
    image { File.open(Rails.root.join('spec', 'fixtures', 'ruby.png')) }
    publisher_url { FFaker::Internet.http_url }
    after(:build) do |material|
      material.tag_list = FFaker::Lorem.words
      material.metadata << FactoryGirl.create(:metadata)
    end
  end
end
