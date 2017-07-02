require 'rails_helper'

RSpec.describe CmsToken, type: :model do
  describe 'validations' do
    subject { build(:cms_token) }
    it { should validate_presence_of :application }
    it { should validate_presence_of :material }
    it { should validate_presence_of :cms_session }
    it { should belong_to(:application) }
    it { should belong_to(:material) }
    it { should belong_to(:cms_session) }
  end
end
