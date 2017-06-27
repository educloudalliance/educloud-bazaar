class CmsSession < ApplicationRecord
  has_one :shopping_cart

  validates :first_name, :last_name, :user_id, :context_id, :context_title, :role,
    :school, :school_id, :city, :city_id, presence: true

  before_create :generate_uid

  enum role: { admin: 0, teacher: 1, student: 2 }, _prefix: :role

  private

  def generate_uid
    self.uid = SecureRandom.uuid
    generate_uid if CmsSession.exists?(uid: self.uid)
  end
end
