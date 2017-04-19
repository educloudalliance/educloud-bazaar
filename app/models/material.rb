class Material < ApplicationRecord
  acts_as_taggable_on :tags

  validates :name, presence: true
  validates :description, presence: true
  validates :language, presence: true
  validates :publisher_resource_id, presence: true, uniqueness: true

  has_attached_file :image, styles: {thumbnail: '150x150#', standard_resolution: '306x306#', low_resolution: '612x612#'}
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }

  self.per_page = 3
end
