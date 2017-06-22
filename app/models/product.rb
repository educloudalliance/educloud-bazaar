class Product < ApplicationRecord
  has_many :product_materials, dependent: :destroy
  has_many :materials, through: :product_materials
  has_many :licenses

  validates :name, presence: true
end
