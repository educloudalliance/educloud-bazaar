FactoryGirl.define do
  factory :material do
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.phrase }
    language { FFaker::Locale.code }
    sequence(:publisher_resource_id) { |n| n + Time.current.to_i }
    # image { File.new(Rails.root.join('public', 'assets', 'images', 'ruby.png')) }
    image { File.open(Rails.root.join('spec', 'fixtures', 'ruby.png')) }
  end
end
