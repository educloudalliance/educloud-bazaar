require 'rails_helper'

RSpec.describe MaterialsMetadata, type: :model do
  describe 'validations' do
    it { should belong_to :material }
    it { should belong_to :metadata }
  end
end
