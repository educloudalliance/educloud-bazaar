FactoryGirl.define do
  factory :token do
    client_id { SecureRandom.hex(16) }
    secret_key { SecureRandom.hex(16) }
  end
end
