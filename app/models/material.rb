class Material < ApplicationRecord
  has_many :material_tags
  has_many :tags, through: :material_tags
  has_many :images

  validates :name, presence: true
  validates :description, presence: true
  validates :language, presence: true
  validates :publisher_resource_id, presence: true, uniqueness: true
end
