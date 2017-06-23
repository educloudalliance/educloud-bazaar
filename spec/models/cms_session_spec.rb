require 'rails_helper'

RSpec.describe CmsSession, type: :model do
  describe 'validations' do
    subject { build(:cms_session) }

    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :context_id }
    it { should validate_presence_of :role }
    it { should validate_presence_of :school }
    it { should validate_presence_of :school_id }
    it { should validate_presence_of :city }
    it { should validate_presence_of :city_id }
    it { should validate_presence_of :context_title }
  end
end
