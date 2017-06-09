class CmsSession < ApplicationRecord
  before_save :generate_uid

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_id, presence: true
  validates :context_id, presence: true
  validates :role, presence: true
  validates :school, presence: true
  validates :school_id, presence: true
  validates :city, presence: true
  validates :city_id, presence: true

  enum role: {admin: 0, teacher: 1, student: 2}, _prefix: :role

  private

  def generate_uid
    self.uid = SecureRandom.uuid
    generate_uid if CmsSession.exists?(uid: self.uid)
  end
end
