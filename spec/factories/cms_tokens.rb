FactoryGirl.define do
  factory :cms_token do
    token { SecureRandom.urlsafe_base64(50) }
    association :material
    association :cms_session
    association :account
  end
end
