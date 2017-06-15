require 'rails_helper'

RSpec.describe License, type: :model do
  it { should validate_presence_of :product }

  context 'when school_id present' do
    subject { FactoryGirl.build(:license, school_id: 123_456) }

    it { should validate_presence_of :city_id }
  end

  context 'when school_id is not present' do
    subject { FactoryGirl.build(:license, school_id: nil) }

    it { should_not validate_presence_of :city_id }
  end
end
