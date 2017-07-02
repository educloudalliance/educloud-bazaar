class Material < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :application, class_name: Doorkeeper::Application
  has_many :product_materials, source: :material_id, dependent: :destroy
  has_many :products, through: :product_materials

  has_many :materials_metadata, dependent: :destroy
  has_many :metadata, through: :materials_metadata

  has_many :shopping_cart_items, class_name: 'ShoppingCartItem'

  has_attached_file :image,
    styles: { thumbnail: '150x150#', standard_resolution: '306x306#', low_resolution: '612x612#' }
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
                       size: { less_than: 5.megabytes }

  validates :name, :description, :language, presence: true
  validates :publisher_resource_id, presence: true, uniqueness: true

  scope :by_viewer, (->(city_id, school_id) {
    joins(products: :licenses).where(licenses: { school_id: [nil, school_id], city_id: [nil, city_id] }).distinct
  })

  self.per_page = 100
end
