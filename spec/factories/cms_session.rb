FactoryGirl.define do
  factory :cms_session do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    user_id { SecureRandom.hex(10) }
    context_id { SecureRandom.hex(10) }
    context_title { FFaker::Lorem.word }
    role { %i[admin teacher student].sample }
    school { FFaker::Education.school }
    school_id { SecureRandom.hex(10) }
    city { FFaker::Address.city }
    city_id { SecureRandom.hex(10) }
    oid { FFaker::Guid.guid }
    add_resource_callback_url { FFaker::Internet.http_url }
    cancel_url { FFaker::Internet.http_url }
    association :shopping_cart
  end
end
