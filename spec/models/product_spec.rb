require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:product_materials).dependent(:destroy) }
  it { should have_many(:materials).through(:product_materials) }
end
