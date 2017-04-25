FactoryGirl.define do
  factory :metadata, class: 'Metadata' do
    country { FFaker::Locale.code.downcase }
    subject { "/#{FFaker::Lorem.word}/#{FFaker::Lorem.word}" }
  end
end
