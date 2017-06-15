require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:kind) }

  it { should define_enum_for(:kind).with(Account.kinds.keys) }
  it { should have_many(:oauth_access_tokens).class_name('Doorkeeper::AccessToken') }
  it { should have_many(:materials) }
end
