require 'rails_helper'

RSpec.describe Metadata, type: :model do
  describe 'validations' do
    it { should validate_presence_of :country }
    it { should have_many(:materials_metadata).dependent(:destroy) }
    it { should have_many(:materials).through(:materials_metadata) }
  end
end
