FactoryGirl.define do
  factory :oauth_application, class: Doorkeeper::Application do
    name { FFaker::Lorem.word }
    uid { FFaker::Guid.guid }
    redirect_uri { FFaker::Internet.uri('https') }
  end
end
