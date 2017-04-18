FactoryGirl.define do
  factory :image do
    url { FFaker::Internet.http_url }
    type { Image.types.keys.sample }
    width rand(1..200)
    height rand(1..200)
  end
end
