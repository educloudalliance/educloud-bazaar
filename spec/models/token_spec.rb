require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'validations' do
    subject { FactoryGirl.build(:token) }
    it { should validate_presence_of :client_id }
    it { should validate_presence_of :secret_key }
    it { should validate_uniqueness_of :client_id }
    it { should validate_uniqueness_of :secret_key }
  end
end
