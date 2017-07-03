FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    association :application, factory: :oauth_application
    expires_in 7200
  end
end
