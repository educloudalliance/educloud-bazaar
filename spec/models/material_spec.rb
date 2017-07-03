require 'rails_helper'

RSpec.describe Material, type: :model do
  describe 'validations' do
    subject { FactoryGirl.build(:material) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :language }
    it { should validate_uniqueness_of :publisher_resource_id }
    it { should have_attached_file :image }
    it { should validate_attachment_content_type(:image).allowing('image/jpeg', 'image/png', 'image/gif') }
    it { should validate_attachment_size(:image).less_than(5.megabytes) }

    it { should belong_to(:application) }
    it { should have_many(:materials_metadata).dependent(:destroy) }
    it { should have_many(:metadata).through(:materials_metadata) }
  end
end
