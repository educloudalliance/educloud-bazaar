class CmsSession < ApplicationRecord
  has_one :shopping_cart

  validates :user_id, :role, :school, :school_id, :city, :city_id, presence: true

  before_create :generate_uid

  private

  def generate_uid
    self.uid = SecureRandom.uuid
    generate_uid if CmsSession.exists?(uid: self.uid)
  end
end
