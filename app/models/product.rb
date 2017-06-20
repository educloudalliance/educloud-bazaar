class Product < ApplicationRecord
  validates :name, presence: true

  has_many :product_materials, dependent: :destroy
  has_many :materials, through: :product_materials
  has_many :licenses
end
