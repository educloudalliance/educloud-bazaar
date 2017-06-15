require 'rails_helper'

RSpec.describe ProductMaterial, type: :model do
  it { should belong_to(:product) }
  it { should belong_to(:material) }

  it { should validate_presence_of(:product) }
  it { should validate_presence_of(:material) }
end
