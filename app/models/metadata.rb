class Metadata < ApplicationRecord
  has_many :materials_metadata, dependent: :destroy
  has_many :materials, through: :materials_metadata

  validates :country, presence: true
end
