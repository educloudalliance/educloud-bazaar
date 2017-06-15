class ProductMaterial < ApplicationRecord
  belongs_to :product
  belongs_to :material

  validates :product, :material, presence: true
end
