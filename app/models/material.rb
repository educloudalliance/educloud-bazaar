class Material < ApplicationRecord
  has_many :material_tags
  has_many :tags, through: :material_tags
  has_many :images
end
